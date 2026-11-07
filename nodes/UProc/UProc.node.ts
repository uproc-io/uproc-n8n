import type {
	IDataObject,
	INodeExecutionData,
	INodeType,
	INodeTypeDescription,
} from 'n8n-workflow';
import { NodeConnectionTypes, NodeOperationError } from 'n8n-workflow';
import { uProcDescription } from './uProc.resource';

export class UProc implements INodeType {
	description: INodeTypeDescription = {
		displayName: 'UProc',
		name: 'uProc',
		icon: { light: 'file:uproc-light.svg', dark: 'file:uproc-dark.svg' },
		group: ['input'],
		version: 1,
		subtitle: '={{$parameter["operation"] + ": " + $parameter["tool"]}}',
		description: 'Consume UProc data processing tools',
		defaults: {
			name: 'UProc',
		},
		usableAsTool: true,
		inputs: [NodeConnectionTypes.Main],
		outputs: [NodeConnectionTypes.Main],
		credentials: [
			{
				name: 'uProcApi',
				required: true,
			},
		],
		requestDefaults: {
			baseURL: 'https://api.uproc.io/api/v2',
			headers: {
				Accept: 'application/json',
				'Content-Type': 'application/json',
			},
		},
		properties: [
			{
				displayName: 'Resource',
				name: 'resource',
				type: 'options',
				noDataExpression: true,
				options: [
					{
						name: 'Audio',
						value: 'audio',
						description: 'Audio processing tools',
					},
					{
						name: 'Communication',
						value: 'communication',
						description:
							'Email validation, phone lookup, SMS verification',
					},
					{
						name: 'Company',
						value: 'company',
						description: 'Company information, financial data, employee lookup',
					},
					{
						name: 'Finance',
						value: 'finance',
						description: 'IBAN validation, bank lookup, financial checks',
					},
					{
						name: 'Geographic',
						value: 'geographic',
						description: 'IP geolocation, address validation, country lookup',
					},
					{
						name: 'Image',
						value: 'image',
						description: 'Image processing tools',
					},
					{
						name: 'Internet',
						value: 'internet',
						description: 'Domain information, website checks',
					},
					{
						name: 'Personal',
						value: 'personal',
						description: 'Person lookup, social media profiles',
					},
					{
						name: 'Product',
						value: 'product',
						description: 'Product information tools',
					},
					{
						name: 'Security',
						value: 'security',
						description: 'IP reputation, threat detection',
					},
					{
						name: 'Text',
						value: 'text',
						description: 'Text processing tools',
					},
				],
				default: 'communication',
			},
			{
				displayName: 'Show Tool',
				name: 'showTool',
				type: 'hidden',
				default: 'true',
			},
		],
	};

	// The function below is responsible for actually doing whatever this node
	// is supposed to do. In this case, we're making an HTTP request to the
	// UProc API. You can make async calls and use `await`.
	async execute(this: IExecuteFunctions): Promise<INodeExecutionData[][]> {
		const items = this.getInputData();
		const returnData: INodeExecutionData[] = [];

		for (let itemIndex = 0; itemIndex < items.length; itemIndex++) {
			try {
				// Get parameters from the node configuration
				const showTool =
					this.getNodeParameter('showTool', itemIndex, true) as boolean;
				const body = this.getNodeParameter('body', itemIndex, {}) as IDataObject;

				if (showTool === true) {
					// The user has selected a tool — execute it
					const tool = this.getNodeParameter('tool', itemIndex, '') as string;

					const options = {};
					const bodyData = {
						processor: tool,
						params: body,
					};

					const response = await this.helpers.requestWithAuthentication.call(
						this,
						'uProcApi',
						{
							url: '/process',
							method: 'POST',
							body: bodyData,
							json: true,
						},
					);

					const item = items[itemIndex];

					if (response && (response as IDataObject).error === false) {
						item.json.message = response.message;
					} else {
						item.json.error = response;
					}

					returnData.push(item);
				} else {
					// The user has not selected a tool yet — list available tools
					const resource =
						this.getNodeParameter('resource', itemIndex, '') as string;
					const tool = this.getNodeParameter('tool', itemIndex, '') as string;

					const options = {};
					const response = await this.helpers.requestWithAuthentication.call(
						this,
						'uProcApi',
						{
							url: `/zapier/processor/${tool}`,
							method: 'GET',
							json: true,
						},
					);

					const item = items[itemIndex];
					item.json.message = response;

					returnData.push(item);
				}
			} catch (error) {
				if (this.continueOnFail()) {
					returnData.push({
						json: this.getInputData(itemIndex)[0].json,
						error,
						pairedItem: { item: itemIndex },
					});
				} else {
					error.context = { itemIndex };
					throw error;
				}
			}
		}

		return [returnData];
	}
}