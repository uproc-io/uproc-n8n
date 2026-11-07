import type { INodeTypeProperties } from 'n8n-workflow';

export const uProcDescription: INodeTypeProperties[] = [
	{
		displayName: 'Tool',
		name: 'tool',
		type: 'options',
		description:
			'The tool to execute. Choose from the available UProc data processing tools.',
		default: '',
		hint: 'Select a tool to see its parameters',
		options: [
			{
				name: 'Select Tool First',
				value: '',
				description: 'Choose a category above to see available tools',
			},
			{
				name: 'Audio Tools',
				value: 'audio',
				description: 'Audio processing tools',
			},
			{
				name: 'Communication Tools',
				value: 'communication',
				description: 'Email, phone, SMS tools',
			},
			{
				name: 'Company Tools',
				value: 'company',
				description: 'Company lookup, financial, employee data',
			},
			{
				name: 'Finance Tools',
				value: 'finance',
				description: 'IBAN, bank, financial checks',
			},
			{
				name: 'Geographic Tools',
				value: 'geographic',
				description: 'IP, address, country lookup',
			},
			{
				name: 'Image Tools',
				value: 'image',
				description: 'Image processing tools',
			},
			{
				name: 'Internet Tools',
				value: 'internet',
				description: 'Domain and website tools',
			},
			{
				name: 'Personal Tools',
				value: 'personal',
				description: 'Person lookup, social media',
			},
			{
				name: 'Product Tools',
				value: 'product',
				description: 'Product information tools',
			},
			{
				name: 'Security Tools',
				value: 'security',
				description: 'IP reputation, threat detection',
			},
			{
				name: 'Text Tools',
				value: 'text',
				description: 'Text processing tools',
			},
		],
		default: '',
	},
	{
		displayName: 'Body',
		name: 'body',
		type: 'json',
		typeOptions: {
			editor: 'codeEditor',
		},
		default: '{}',
		description: 'JSON body with parameters for the selected tool',
		placeholder: '{"email": "test@example.com"}',
	},
];