import { gptsType, mlog } from "@/api";
import { reactive } from "vue";
import { ss } from "@/utils/storage";

export const homeStore = reactive({ // 记录当前正在发生的事情
	myData: {
		act: "", //动作
		actData: {}, //动作类别
		local: "", //当前所处的版本
		session: {} as any,
		isLoader: false,
	},

	setMyData(v: object) { // 广播一个新动作
		this.myData = { ...this.myData, ...v };
		if (Object.keys(v).indexOf("act") > -1) {
			setTimeout(() => {
				this.myData.act = "";
				this.myData.actData = "";
			}, 2000);
		}
	},
});

export interface gptConfigType { // 存储 GPT 模型的配置
	model: string;
	modelLabel: string; // 模型的显示名称
	max_tokens: number; // 最大回复长度
	userModel?: string; //自定义模型名称 可选
	talkCount: number; //连续对话次数
	systemMessage: string; //自定义系统提示语
	kid: string; //知识库id
	kName: string; //知识库名称
	gpts?: gptsType; // 关联的GPTs模型（可选）
	uuid?: number;
	temperature?: number; // 随机性 : 值越大，回复越随机
	top_p?: number; // 核采样 : 与随机性类似，但不要和随机性一起更改
	frequency_penalty?: number; // 重复内容惩罚（越大越避免重复）
	presence_penalty?: number; // 新内容奖励（越大越可能说新话题）
	tts_voice?: string; //TTS 人物 声音
}
const getGptInt = (): gptConfigType => { // 启动时加载配置
	let v: gptConfigType = getDefault(); // 读默认
	let str = localStorage.getItem("gptConfigStore"); //读存在本地的配置
	if (str) {
		let old = JSON.parse(str);
		if (old) v = { ...v, ...old }; // 合并
	}
	return v;
};

const getDefault = () => {
	const amodel = homeStore.myData.session.amodel ?? "deepseek/deepseek-r1";
	let v: gptConfigType = {
		model: amodel,
		modelLabel: "",
		max_tokens: 1024,
		userModel: "",
		talkCount: 10,
		systemMessage: "",
		temperature: 0.5,
		top_p: 1,
		presence_penalty: 0,
		frequency_penalty: 0,
		tts_voice: "alloy",
		kid: "",
		kName: "",
	};
	return v;
};
export const gptConfigStore = reactive({ // 状态管理
	myData: getGptInt(),
	setMyData(v: Partial<gptConfigType>) { // 修改配置（传入新的）
		this.myData = { ...this.myData, ...v }; // 合并
		//mlog('gptConfigStore', v )
		if (v.model && !v.gpts) this.myData.gpts = undefined; // 切换模型时清空关联的GPTs

		localStorage.setItem("gptConfigStore", JSON.stringify(this.myData)); // 保存到本地
	},
	setInit() { // 恢复默认配置
		this.setMyData(getDefault());
	},
});

export interface gptServerType { // 记录服务器信息和api配置
	OPENAI_API_KEY: string; // OpenAI的API密钥
	OPENAI_API_BASE_URL: string;  // API服务器地址（比如"https://api.openai.com"）
	MJ_SERVER: string; // MidJourney绘图服务器地址
	MJ_API_SECRET: string; // MidJourney的API密钥
	UPLOADER_URL: string; // 文件上传服务器地址
	MJ_CDN_WSRV?: boolean; //是否用wsrv.nl加速图片（可选）
}

const getServerDefault = () => {
	let v: gptServerType = {
		OPENAI_API_KEY: "",
		OPENAI_API_BASE_URL: "",
		MJ_SERVER: "",
		UPLOADER_URL: "",
		MJ_API_SECRET: "",
		MJ_CDN_WSRV: false,
	};
	return v;
};
const getServerInit = (): gptServerType => { // 启动时加载配置
	let v: gptServerType = getServerDefault();
	let str = localStorage.getItem("gptServerStore");
	if (str) {
		let old = JSON.parse(str);
		if (old) v = { ...v, ...old };
	}
	return v;
};

export const gptServerStore = reactive({
	myData: getServerInit(),
	setMyData(v: Partial<gptServerType>) {
		this.myData = { ...this.myData, ...v };
		localStorage.setItem("gptServerStore", JSON.stringify(this.myData));
	},
	setInit() {
		this.setMyData(getServerDefault());
	},
});

const gptsUlistInit = (): gptsType[] => { // 记录GPTs 使用历史
	const lk = ss.get("gpts-use-list"); // // ss是封装的localStorage工具 从本地读记录
	if (!lk) return [];
	return lk as gptsType[];
};

//使用gtps列表
export const gptsUlistStore = reactive({
	myData: gptsUlistInit(),
	setMyData(v: gptsType) {
		this.myData = this.myData.filter((v2) => v2.gid != v.gid); // 先删除列表中已有的相同模型（去重）
		this.myData.unshift(v); // 把新模型放到列表最前面
		ss.set("gpts-use-list", this.myData); // 保存本地
		return this;
	},
});
