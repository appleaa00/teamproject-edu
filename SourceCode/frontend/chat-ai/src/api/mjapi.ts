
import {  gptServerStore, homeStore, useAuthStore } from "@/store";
import { copyToClip } from "@/utils/copy";
import { getToken } from "@/store/modules/auth/helper";
import { localGet, localSaveAny } from "./mjsave";
import { t } from "@/locales";
//import { useMessage } from "naive-ui";
export interface gptsType{
    gid:string
    name:string
    logo:string
    info:string
    use_cnt?:string
    id:string
    bad?:string|number
    modelName:string
}

// 图片文件上传（保持兼容性）
export function upImg(file: any): Promise<any> {
    return upFile(file, 'image');
}

// 通用文件上传函数
export function upFile(file: any, expectedType?: string): Promise<any> {
    const maxSize = homeStore.myData.session.uploadImgSize ? (+homeStore.myData.session.uploadImgSize) : 50; // 提升到50MB
    
    return new Promise((resolve, reject) => {
        const filename = file.name;
        const fileExtension = filename.toLowerCase().split('.').pop();
        
        // 文件大小检查
        if (file.size > (1024 * 1024 * maxSize)) {
            reject(t('mjchat.no1m', { m: maxSize }))
            return;
        }
        
        // 获取文件类型和图标
        const fileInfo = getFileTypeInfo(filename, file.size);
        
        // 如果指定了期望类型，进行验证
        if (expectedType === 'image' && fileInfo.category !== 'image') {
            reject('只能上传图片文件');
            return;
        }
        
        // 创建FormData对象
        const formData = new FormData();
        formData.append('file', file);

        // 调用后台上传接口
        const header = {
            'Authorization': 'Bearer ' + getToken()
        };

        fetch('/api/resource/oss/upload', {
            method: 'POST',
            headers: header,
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.code === 200) {
                // 返回上传成功的结果，包含文件类型信息
                resolve({
                    url: data.data.url,
                    fileName: data.data.fileName,
                    originalName: filename,
                    ossId: data.data.ossId,
                    fileSize: file.size,
                    fileType: fileInfo.category,
                    icon: fileInfo.icon,
                    extension: fileExtension
                });
            } else {
                reject(data.msg || '上传失败');
            }
        })
        .catch(error => {
            reject('上传失败: ' + error.toString());
        });
    })
}

// 获取文件类型信息
export function getFileTypeInfo(filename: string, fileSize: number) {
    const extension = filename.toLowerCase().split('.').pop() || '';
    
    // 文件类型映射
    const typeMap: Record<string, {category: string, icon: string, color: string}> = {
        // 图片文件
        'jpg': { category: 'image', icon: 'mdi:file-image', color: '#4CAF50' },
        'jpeg': { category: 'image', icon: 'mdi:file-image', color: '#4CAF50' },
        'png': { category: 'image', icon: 'mdi:file-image', color: '#4CAF50' },
        'gif': { category: 'image', icon: 'mdi:file-image', color: '#4CAF50' },
        'bmp': { category: 'image', icon: 'mdi:file-image', color: '#4CAF50' },
        'webp': { category: 'image', icon: 'mdi:file-image', color: '#4CAF50' },
        'svg': { category: 'image', icon: 'mdi:file-image', color: '#4CAF50' },
        
        // 文档文件
        'pdf': { category: 'document', icon: 'mdi:file-pdf-box', color: '#F44336' },
        'doc': { category: 'document', icon: 'mdi:file-word', color: '#2196F3' },
        'docx': { category: 'document', icon: 'mdi:file-word', color: '#2196F3' },
        'xls': { category: 'document', icon: 'mdi:file-excel', color: '#4CAF50' },
        'xlsx': { category: 'document', icon: 'mdi:file-excel', color: '#4CAF50' },
        'ppt': { category: 'document', icon: 'mdi:file-powerpoint', color: '#FF9800' },
        'pptx': { category: 'document', icon: 'mdi:file-powerpoint', color: '#FF9800' },
        'txt': { category: 'document', icon: 'mdi:file-document', color: '#757575' },
        'rtf': { category: 'document', icon: 'mdi:file-document', color: '#757575' },
        
        // 代码文件
        'js': { category: 'code', icon: 'mdi:language-javascript', color: '#FFD600' },
        'ts': { category: 'code', icon: 'mdi:language-typescript', color: '#3178C6' },
        'html': { category: 'code', icon: 'mdi:language-html5', color: '#E34F26' },
        'css': { category: 'code', icon: 'mdi:language-css3', color: '#1572B6' },
        'java': { category: 'code', icon: 'mdi:language-java', color: '#ED8B00' },
        'py': { category: 'code', icon: 'mdi:language-python', color: '#3776AB' },
        'cpp': { category: 'code', icon: 'mdi:language-cpp', color: '#00599C' },
        'c': { category: 'code', icon: 'mdi:language-c', color: '#A8B9CC' },
        'vue': { category: 'code', icon: 'mdi:vuejs', color: '#4FC08D' },
        'json': { category: 'code', icon: 'mdi:code-json', color: '#000000' },
        'xml': { category: 'code', icon: 'mdi:file-xml', color: '#FF6600' },
        
        // 音频文件
        'mp3': { category: 'audio', icon: 'mdi:file-music', color: '#9C27B0' },
        'wav': { category: 'audio', icon: 'mdi:file-music', color: '#9C27B0' },
        'flac': { category: 'audio', icon: 'mdi:file-music', color: '#9C27B0' },
        'aac': { category: 'audio', icon: 'mdi:file-music', color: '#9C27B0' },
        'ogg': { category: 'audio', icon: 'mdi:file-music', color: '#9C27B0' },
        
        // 视频文件
        'mp4': { category: 'video', icon: 'mdi:file-video', color: '#E91E63' },
        'avi': { category: 'video', icon: 'mdi:file-video', color: '#E91E63' },
        'mov': { category: 'video', icon: 'mdi:file-video', color: '#E91E63' },
        'wmv': { category: 'video', icon: 'mdi:file-video', color: '#E91E63' },
        'flv': { category: 'video', icon: 'mdi:file-video', color: '#E91E63' },
        
        // 压缩文件
        'zip': { category: 'archive', icon: 'mdi:folder-zip', color: '#795548' },
        'rar': { category: 'archive', icon: 'mdi:folder-zip', color: '#795548' },
        '7z': { category: 'archive', icon: 'mdi:folder-zip', color: '#795548' },
        'tar': { category: 'archive', icon: 'mdi:folder-zip', color: '#795548' },
        'gz': { category: 'archive', icon: 'mdi:folder-zip', color: '#795548' },
    };
    
    const fileInfo = typeMap[extension] || { 
        category: 'other', 
        icon: 'mdi:file', 
        color: '#607D8B' 
    };
    
    return {
        ...fileInfo,
        extension,
        size: formatFileSize(fileSize)
    };
}

// 格式化文件大小
export function formatFileSize(bytes: number): string {
    if (bytes === 0) return '0 B';
    const k = 1024;
    const sizes = ['B', 'KB', 'MB', 'GB', 'TB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}

// 解析文档内容
export function parseDocument(ossId: number): Promise<any> {
    return new Promise((resolve, reject) => {
        const header = {
            'Authorization': 'Bearer ' + getToken()
        };

        fetch(`/chat/document/parse?ossId=${ossId}`, {
            method: 'POST',
            headers: header
        })
        .then(response => {
            // 检查响应状态
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            // 检查是否是JSON响应
            const contentType = response.headers.get('content-type');
            if (!contentType || !contentType.includes('application/json')) {
                throw new Error('服务器返回非JSON响应');
            }
            return response.json();
        })
        .then(data => {
            if (data && data.code === 200) {
                resolve({
                    content: data.data,
                    message: data.msg || '解析成功'
                });
            } else {
                reject(data?.msg || '解析失败');
            }
        })
        .catch(error => {
            console.error('文档解析错误:', error);
            reject('解析失败: ' + error.toString());
        });
    });
}

// 批量解析文档内容
export function parseDocuments(ossIds: number[]): Promise<any> {
    return new Promise((resolve, reject) => {
        const header = {
            'Authorization': 'Bearer ' + getToken(),
            'Content-Type': 'application/json'
        };

        fetch('/chat/document/parse-batch', {
            method: 'POST',
            headers: header,
            body: JSON.stringify(ossIds)
        })
        .then(response => {
            // 检查响应状态
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            // 检查是否是JSON响应
            const contentType = response.headers.get('content-type');
            if (!contentType || !contentType.includes('application/json')) {
                throw new Error('服务器返回非JSON响应');
            }
            return response.json();
        })
        .then(data => {
            if (data && data.code === 200) {
                resolve({
                    content: data.data,
                    message: data.msg || '批量解析成功'
                });
            } else {
                reject(data?.msg || '批量解析失败');
            }
        })
        .catch(error => {
            console.error('批量文档解析错误:', error);
            reject('批量解析失败: ' + error.toString());
        });
    });
}

// 检查文件是否支持内容解析
export function isSupportedDocument(extension: string): boolean {
    const supportedTypes = ['pdf', 'doc', 'docx', 'txt', 'md', 'java', 'js', 'py', 'html', 'css', 'xml', 'json'];
    return supportedTypes.includes(extension.toLowerCase());
}

export const file2blob= (selectedFile: any  )=>{
    return new Promise<{blob:Blob,filename:string}>((resolve, reject) => {
        const reader = new FileReader();
        mlog('selectedFile', selectedFile )
        reader.onload = function (event:any ) {
            // 将文件内容转换为 Blob
            const blob = new Blob([event.target.result], { type: selectedFile.type });

            // 在这里可以使用生成的 Blob 对象
            //console.log(blob);
            resolve({blob,filename:selectedFile.name });
        };
        reader.onerror = (e)=> reject(e);

        // 开始读取文件
        reader.readAsArrayBuffer(selectedFile);

    })

}

export const blob2file= ( blob:Blob,fileName:string )=>{
    const file = new File([blob], fileName, { type: blob.type, lastModified: Date.now() });
    return file;
}

export const  isFileMp3= (filename:string )=>{
    let arr='.mp3, .mp4, .mpeg, .mpga, .m4a, .wav, .webm'.split(/[, ]+/ig);
    mlog('fileIsMp3', arr );
    filename= filename.toLocaleLowerCase();
    for(let ext of arr ){
        if(filename.endsWith(ext)) return true;
    }
    return false;
}

function containsChinese(str:string ) {
  return false; //11.18 都不需要翻译
//   var reg = /[\u4e00-\u9fa5]/g; // 匹配中文的正则表达式
//   return reg.test(str);
}

export  async function train( text:string){

    return new Promise<string>((resolve, reject) => {


        if( text.trim()  =='') {
           reject( t('mjchat.placeInput'));
            return ;
        }


        if( !containsChinese(text.trim()) ){
            resolve( text.trim() );
            return ;
        }

        // myTranslate( text.trim())
        //     .then((d:any)=>  resolve( d.content.replace(/[?.!]+$/, "")))
        //     .catch(( )=>   reject('翻译发生错误'))
        resolve( text.trim() )
    })
}

export const mlog = (msg: string, ...args: unknown[]) => {
    //localStorage.setItem('debug',1 )
    const logStyles = [
    // 'padding: 4px 8px',
    // 'color: #fff',
    // 'border-radius: 3px',
    'color:',
  ].join(';')
    const debug= localStorage.getItem('debug')
    if( !debug  ) return ;
    const style = `${logStyles}${msg.includes('error') ? 'red' : '#dd9089'}`
    console.log(`%c[mjgpt]`,  style, msg , ...args)
}

export const myTrim = (str: string, delimiter: string)=>{
    // 构建正则表达式，使用动态的定界符
    const regex = new RegExp(`^${delimiter}+|${delimiter}+$`, 'g');

    // 使用正则表达式去除字符串两端的定界符
    return str.replace(regex, '');
}

function getHeaderApiSecret(){
    if(!gptServerStore.myData.MJ_API_SECRET){
        const authStore = useAuthStore()
        if( authStore.token ) return { 'x-ptoken':  authStore.token };
        return {}
    }
    return {
        'mj-api-secret':  import.meta.env.VITE_MJ_API_SECRET
    }
}

const getUrl=(url:string)=>{
    if(url.indexOf('http')==0) return url;
    return `/api${url}`;
}

export const mjFetch=(url:string,data?:any)=>{
    mlog('mjFetch2024', url  );
    let header = { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + getToken() };
    header= {...header,...getHeaderApiSecret() }

    return new Promise<any>((resolve, reject) => {
        let opt:RequestInit ={method:'GET'}; 
        opt.headers=header;
        if(data) {
            opt.body= JSON.stringify(data) ;
             opt.method='POST';
        }
        fetch(getUrl(url),  opt )
        .then(d2=>d2.json().then(d=> {
                if(d2.ok) resolve(d);
                else{
                    reject({error: d.error??  (d??'Network response was not ok!'),code:'response_fail',url:getUrl(url), status:d2.status })
                }
            }).catch(e=>reject({error:e? e.toString() :'json_error',code:'json_error',url:getUrl(url) , status:d2.status  }))
        ).catch(e=>reject({error:e? e.toString() :'fetch fail',data ,code:'fetch_fail',url:getUrl(url)  }))
    })
     
}

export const myFetch=(url:string,data?:any)=>{
    //mlog('myFetch', url  );
    let header = { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + getToken() };
    //header= {...header  }

    return new Promise<any>((resolve, reject) => {
        let opt:RequestInit ={method:'GET'}; 
        opt.headers=header;
        if(data) {
            opt.body= JSON.stringify(data) ;
             opt.method='POST';
        }
        fetch(getUrl(url),  opt )
        .then(d=>d.json().then(d=> resolve(d))
        .catch(e=>reject(e)))
        .catch(e=>reject(e))
    })
     
}
export const my2Fetch=(url:string,data?:any)=>{
    mlog('mjFetch', url  );
    let header = { 'Content-Type': 'application/json', 'Authorization': 'Bearer ' + getToken() };
    //header= {...header  }

    return new Promise<any>((resolve, reject) => {
        let opt:RequestInit ={method:'GET'}; 
        opt.headers=header;
        if(data) {
            opt.body= JSON.stringify(data) ;
             opt.method='POST';
        }
        fetch((url),  opt )
        .then(d=>d.json().then(d=> resolve(d))
        .catch(e=>reject(e)))
        .catch(e=>reject(e))
    })
}

export const flechTask= ( chat:Chat.Chat)=>{
    let cnt=0;
    const check= async ()=>{
        cnt++;
        if(!chat.mjID){
            chat.text +="\n获取失败" ;
            chat.loading=false;
            homeStore.setMyData({act:'updateTask', actData:chat });
            return ;
        }
        const ts=  await mjFetch(`/mj/task/${chat.mjID}/fetch`);
        chat.opt= ts;
        chat.loading=   (cnt>=99)?false:true;
        //chat.progress=ts.progress;

        if(ts.progress && ts.progress== "100%") chat.loading=false;

        homeStore.setMyData({act:'updateChat', actData:chat });
        //"NOT_START" //["SUBMITTED","IN_PROGRESS"].indexOf(ts.status)>-1
        if( ["FAILURE","SUCCESS"].indexOf(ts.status)==-1 && cnt<100 ){

            setTimeout(() =>   check( ) , 5000 )
        }
        mlog('task', ts.progress,ts, chat.uuid,chat.index  );
    }
    check();
}
export const subTask= async (data:any, chat:Chat.Chat )=>{
   let d:any;
   try{
    //return ;
    if(  data.action &&data.action=='change' ){ //执行变化
        d=  await mjFetch('/mj/submit/change' , data.data  );
    }else if( data.action &&data.action=="CustomZoom") { //自定义变焦
            d =  await mjFetch('/mj/submit/action' , data.data  );
            if(d.result){
                let bdata= data.maskData;
                bdata.taskId= d.result;
                d=  await mjFetch('/mj/submit/modal' , bdata );
            }
    }else if( data.action &&data.action=='mask') { //局部重绘
        d =  await mjFetch('/mj/submit/action' , data.data  );
        if(d.result){
            let bdata= data.maskData;
            bdata.taskId= d.result;
            d=  await mjFetch('/mj/submit/modal' , bdata );
        }
    }else if( data.action &&data.action=='blend') { //blend
        d=  await mjFetch('/mj/submit/blend' ,  data.data );
    }else if( data.action &&data.action=='shorten') { //shorten
        d=  await mjFetch('/mj/submit/shorten' ,  data.data );
        //  mlog('mjFetch shorten' , data );
    }else if( data.action &&data.action=='face') { //换脸
        d=  await mjFetch('/mj/insight-face/swap' , data.data  );
        //mlog('换年服务', data.data );
        //return;
    }else if( data.action &&data.action=='img2txt') { //图生文
            d=  await mjFetch('/mj/submit/describe' , data.data  );
    }else if( data.action &&data.action=='changeV2') { //执行动作！
        d=  await mjFetch('/mj/submit/action' , data.data  );
    }else {
        let toData =  {
            "base64Array":data.fileBase64??[],
            "notifyHook": "",
            "prompt": data.drawText,
            "state": "",
            botType:'MID_JOURNEY'
            };
            if(data.bot && data.bot=='NIJI_JOURNEY'){
                toData.botType= data.bot;
            }
            d=  await mjFetch('/mj/submit/imagine' ,toData );
            mlog('submit',d );
            //return ;
    }
    if(d.code==21){
        d=  await mjFetch('/mj/submit/modal' , { taskId:d.result} );
    }

     backOpt(d, chat);
   }catch(e:any ){
     mlog('mjFetchError', e )
     chat.text='失败！'+"\n```json\n"+JSON.stringify(e, null, 2)+"\n```\n";
     chat.loading=false;
     homeStore.setMyData({act:'updateChat', actData:chat });
   }
}
const backOpt= (d:any, chat:Chat.Chat )=>{
     if(d.code==1){
        chat.text='提交成功！';
        chat.mjID= d.result;
        flechTask( chat )
        chat.loading=true;
        homeStore.setMyData({act:'updateChat', actData:chat });
        //chat.m= d.result;
    }else{
        chat.text='失败！'+"\n```json\n"+JSON.stringify(d, null, 2)+"\n```\n";
        chat.loading=false;
        homeStore.setMyData({act:'updateChat', actData:chat });
    }
}

export const mjSeed= async ( mjid:string )=>{
     const ts=  await mjFetch(`/mj/task/${mjid}/image-seed`);
     return ts;
}



export const getSeed = async (cchat:Chat.Chat,message:any )=>{
   // const message = useMessage();
  // let cchat = props.chat;
  if(!cchat.mjID ) return ;
  let seed=0 ;
  if(cchat.opt?.seed) seed =cchat.opt?.seed;
  else{
   try{
        message.info('获取中...');
      const res:any  = await mjSeed( cchat.mjID);
      seed= res.result;
      if(seed>0 ) {

        if ( cchat.opt ){
          cchat.opt.seed = seed;

           homeStore.setMyData({act:'updateChat', actData:cchat });
        }
        message.success('获取成功');
      }

   } catch(e){
      message.error('获取失败')
   }
  }
  mlog('getSeed',seed);
  if(seed>0 ) {
    await copyToClip(`${seed}`);
    message.success('复制seed成功');
  }

}

export const getLastVersion=  async ()=>{
    const url='https://api.github.com/repos/Dooy/chatgpt-web-midjourney-proxy/tags?per_page=1';
    const a= await myFetch(url);
    mlog('lastVersion', a );
    return a;

}
export const isCanBase64Model=(model:string)=>{
    if (!model) return false;
    
    // 转换为小写进行匹配，避免大小写问题
    const modelLower = model.toLowerCase();
    
    console.log('🔍 isCanBase64Model 详细匹配过程:', {
        原始模型名: model,
        小写模型名: modelLower
    });
    
    // 先检查基本的模型支持
    let arr=['gpt-image','gpt-4o','gemini','1.5','sonnet','opus'];
    for( let m of arr){
        if(modelLower.indexOf(m)>-1) {
            console.log('✅ 匹配到基础模型:', m);
            return true;
        }
    }
    
    // GPT-4o 专门检查
    if(modelLower.indexOf('gpt-4o')>-1 || ( modelLower.indexOf('gemini')>-1 && modelLower.indexOf('1.5')>-1 ) ){
        console.log('✅ 匹配到GPT-4o或Gemini 1.5');
        return true;
    }
    
    // 新增：更智能的DeepSeek匹配（支持自研模型）
    const deepseekPatterns = ['deepseek', 'deep-seek', 'deep_seek'];
    for (let pattern of deepseekPatterns) {
        if (modelLower.indexOf(pattern) > -1) {
            console.log('✅ 匹配到DeepSeek模型，匹配模式:', pattern);
            return true;
        }
    }
    
    // 新增：更智能的Qwen匹配（支持自研模型）  
    const qwenPatterns = ['qwen', 'qw-en', 'qw_en', 'qianwen', '千问', 'tongyi'];
    for (let pattern of qwenPatterns) {
        if (modelLower.indexOf(pattern) > -1) {
            console.log('✅ 匹配到Qwen模型，匹配模式:', pattern);
            return true;
        }
    }
    
    // 新增：智能检测自研混合模型（包含多个模型名称）
    const hasDeepSeek = deepseekPatterns.some(pattern => modelLower.indexOf(pattern) > -1);
    const hasQwen = qwenPatterns.some(pattern => modelLower.indexOf(pattern) > -1);
    
    if (hasDeepSeek && hasQwen) {
        console.log('✅ 检测到DeepSeek+Qwen混合模型');
        return true;
    }
    
    // 新增：检测包含"自研"、"custom"、"混合"等关键词的模型
    const customKeywords = ['自研', 'custom', '混合', 'hybrid', 'combined', 'multi', 'fusion'];
    for (let keyword of customKeywords) {
        if (modelLower.indexOf(keyword) > -1 && (hasDeepSeek || hasQwen)) {
            console.log('✅ 检测到自研模型，关键词:', keyword);
            return true;
        }
    }
    
    // 原有的visionArr检查
    let visionArr=['gemini-pro-vision','gpt-4o-2024-08-06','gpt-4o-2024-11-20','gpt-4o','gpt-4o-2024-05-13','gpt-4o-mini','gpt-4o-mini-2024-07-18','gemini-pro-1.5','gpt-4-turbo','gpt-4-turbo-2024-04-09','gpt-4-vision-preview','luma-video','claude-3-5-sonnet-20240620' ,'claude-3-sonnet-20240229','claude-3-opus-20240229'];
    
    if( homeStore.myData.session.customVisionModel ){ 
        homeStore.myData.session.customVisionModel.split(/[ ,]+/ig).map( (v:string)=>{
            visionArr.push( v.toLowerCase() );
        });
    }
    
    if (visionArr.indexOf(modelLower) > -1) {
        console.log('✅ 匹配到visionArr中的模型');
        return true;
    }
    
    console.log('❌ 未匹配到任何支持的模型');
    return false;
}
export const canVisionModel= (model:string)=>{
    if (!model) return false;
    
    // 转换为小写进行匹配
    const modelLower = model.toLowerCase();
    
    console.log('🔍 canVisionModel 匹配过程:', {
        原始模型名: model,
        小写模型名: modelLower
    });
    
    // GPT-4 系列模型支持
    if( ['gpt-4-all','gpt-4-v','gpt-4v','gpt-3.5-net'].indexOf(modelLower)>-1 ) return true;
    if(modelLower.indexOf('gpt-4-gizmo')>-1 || modelLower.indexOf('claude-3-opus')>-1 )return true;
    
    // 新增：更智能的DeepSeek匹配（支持自研模型）
    const deepseekPatterns = ['deepseek', 'deep-seek', 'deep_seek'];
    for (let pattern of deepseekPatterns) {
        if (modelLower.indexOf(pattern) > -1) {
            console.log('✅ canVisionModel 匹配到DeepSeek模型');
            return true;
        }
    }
    
    // 新增：更智能的Qwen匹配（支持自研模型）  
    const qwenPatterns = ['qwen', 'qw-en', 'qw_en', 'qianwen', '千问', 'tongyi'];
    for (let pattern of qwenPatterns) {
        if (modelLower.indexOf(pattern) > -1) {
            console.log('✅ canVisionModel 匹配到Qwen模型');
            return true;
        }
    }
    
    // 新增：智能检测自研混合模型
    const hasDeepSeek = deepseekPatterns.some(pattern => modelLower.indexOf(pattern) > -1);
    const hasQwen = qwenPatterns.some(pattern => modelLower.indexOf(pattern) > -1);
    
    if (hasDeepSeek || hasQwen) {
        console.log('✅ canVisionModel 检测到DeepSeek或Qwen相关模型');
        return true;
    }
    
    console.log('❌ canVisionModel 未匹配到支持的模型');
    return false;
}

export const isTTS= ( model:string )=>{
    if(model.indexOf('tts-1')===0 )return true;
    return false ;
}

function isStringOnlyDigits(input: string): boolean {
    // 使用正则表达式检查字符串是否只包含数字
    const regex = /^[0-9]+$/;
    return regex.test(input);
}
export const loadGallery  = async ()=>{
     let localKey= 'mj-list-condition';
     const d2:any = await localGet(localKey);
     //mlog('d2',d2 , (Date.now()- d2.ctime));
     if(d2 && (Date.now()- d2.ctime)<300*1000 ){

        return d2.d as any[];
     }
     let  d =  await mjFetch(`/mj/gallery`);
     //mlog('tsList', d.data.list   );
     if( !d.data.list  ||  d.data.list.length ==0 ) return [];
     const list =d.data.list as any[];
     const ids = list.filter(v=> isStringOnlyDigits(v.reqid)).map(v=> +v.reqid ) ;
     mlog('ids',  ids   );
     if(ids.length==0) return [];
     ///mj/task/list-by-condition
     d=  await mjFetch('/mj/task/list-by-condition',{ids } );

     if( d.length>0 ) localSaveAny({ctime: Date.now(), d}, localKey);
     return d as any[] ;
}

//从剪贴板中读取文件
export   function getFileFromClipboard(event:any ){
    let rz=[];
    if ( event.clipboardData || event.originalEvent ) {
        let clipboardData = (event.clipboardData || event.originalEvent.clipboardData);
        if (clipboardData.items) {
            let items = clipboardData.items;
            // mlog('getFileFromClipboard',  items  );
            for (let i = 0; i < items.length; i++) {
                if (items[i].type.indexOf("image") !== -1 || items[i].kind === 'file') {
                    //rz.push( await fileToBase64(  items[i].getAsFile()) );
                    //mlog('fff', items[i] );
                    rz.push( items[i].getAsFile())
                }
            }

        }
    }
    //console.log('passs>>' ,rz );
    return rz;
}
