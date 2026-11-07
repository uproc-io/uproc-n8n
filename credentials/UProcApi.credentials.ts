import type {
	IAuthenticateGeneric,
	Icon,
	ICredentialTestRequest,
	ICredentialType,
	INodeProperties,
} from 'n8n-workflow';

export class UProcApi implements ICredentialType {
	name = 'uProcApi';

	displayName = 'UProc API';

	icon: Icon = { light: 'file:uproc-light.svg', dark: 'file:uproc-dark.svg' };

	documentationUrl = 'https://docs.uproc.io';

	properties: INodeProperties[] = [
		{
			displayName: 'Email',
			name: 'email',
			type: 'string',
			default: '',
			placeholder: 'user@uproc.io',
			description: 'Your UProc account email (Username)',
		},
		{
			displayName: 'API Key',
			name: 'apiKey',
			type: 'string',
			typeOptions: { password: true },
			default: '',
			description:
				'Your UProc API key from Settings → Integrations page',
		},
	];

	authenticate: IAuthenticateGeneric = {
		type: 'generic',
		properties: {
			headers: {
				Authorization:
					'=Basic {{base64($credentials.email + ":" + $credentials.apiKey)}}',
			},
		},
	};

	test: ICredentialTestRequest = {
		request: {
			baseURL: 'https://api.uproc.io/api/v2',
			url: '/profile',
			method: 'GET',
		},
	};
}