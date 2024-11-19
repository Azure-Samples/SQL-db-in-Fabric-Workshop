import { InteractiveBrowserCredential } from "@azure/identity";
import promptSync from 'prompt-sync';

let app = new InteractiveBrowserCredential({});
let tokenPromise = app.getToken('https://analysis.windows.net/powerbi/api/user_impersonation');
let accessToken = await tokenPromise;

const prompt = promptSync();
const sessions_like = prompt("What kind of sesssions are you looking for? ");

console.log(`looking for sessions like ${sessions_like}...`);


const endpoint = 'https://dxtapi.fabric.microsoft.com/v1/workspaces/3ccfa592-62c4-43bd-84b2-b2519d4a4a00/graphqlapis/bbcab74e-459e-48ac-9138-978145b574e1/graphql';
const query = `

  query{
    executefind_sessions_wrapper (text: "${sessions_like}") {
       title
    }
  }
`;

const headers = {
	'Content-Type': 'application/json',
	'Authorization': `Bearer ${accessToken.token}`
};

async function fetchData() 	{
	try {
		const response = await fetch(endpoint, {
			method: 'POST',
			headers: headers,
			body: JSON.stringify({ query }),
		});

		const result = await response.json();
		console.log(JSON.stringify(result, null, 2)); // JSON formatting
	} catch (error) {
		console.log('Error fetching data:', error);
	}
}

fetchData();

