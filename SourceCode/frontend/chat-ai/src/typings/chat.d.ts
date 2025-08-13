declare namespace Chat {

	interface Chat { // 单条聊天消息的结构
		dateTime: string
		text: string
		inversion?: boolean
		error?: boolean
		loading?: boolean
		conversationOptions?: ConversationRequest | null
		requestOptions: { prompt: string; options?: ConversationRequest | null }
		model?:string //模型
		mjID?:string //MJ的ID
		opt?:{
			progress?:string,seed?:number, imageUrl?:string
			, status?:string, images?:string[]
			,promptEn?:string,buttons?:any[]
			,action?:string
			,duration?:number
			,lkey?:string
		} //
		uuid?:number
		index?:number
		myid?:string //唯一随机
		logo?:string

		//progress?:string
	}

	interface History { // 会话历史记录的条目
		title: string
		isEdit: boolean
		uuid: number
	}

	interface ChatState { // 整个聊天功能的状态管理结构
		active: number | null
		usingContext: boolean;
		history: History[]
		chat: { uuid: number; data: Chat[] }[]
	}

	interface ConversationRequest { // 与 AI 对话的请求参数
		conversationId?: string
		parentMessageId?: string
	}

	interface ConversationResponse { // AI 对话的响应结构
		conversationId: string
		detail: {
			choices: { finish_reason: string; index: number; logprobs: any; text: string }[]
			created: number
			id: string
			model: string
			object: string
			usage: { completion_tokens: number; prompt_tokens: number; total_tokens: number }
		}
		id: string
		parentMessageId: string
		role: string
		text: string
	}
}
