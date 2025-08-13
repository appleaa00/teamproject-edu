<script setup lang='ts'>
import { computed,   ref,watch  } from 'vue'
import { useRoute } from 'vue-router'
import { useChat } from '../chat/hooks/useChat'
import {  homeStore, useChatStore } from '@/store'
import { getInitChat, mlog, subModel,getSystemMessage , localSaveAny, canVisionModel
    ,isTTS, subTTS, file2blob, whisperUpload, getHistoryMessage, checkDisableGpt4, chatSetting, isCanBase64Model, formatFileSize, parseDocuments, isSupportedDocument, } from '@/api'
//import { isNumber } from '@/utils/is'
import { useMessage  } from "naive-ui";
import { t } from "@/locales";

const emit = defineEmits(['finished']);
const { addChat , updateChatSome } = useChat()
const chatStore = useChatStore()
const st=ref({uuid:'1002', index:-1, chatType:0, appId:'' });
const controller = ref<AbortController>( );;// new AbortController();
const dataSources = computed(() => chatStore.getChatByUuid(+st.value.uuid))
const ms= useMessage();
const textRz= ref<string[]>([]);
const goFinish= (  )=>{
    //let dindex = st.value.index>=0? st.value.index : dataSources.value.length - 1;
    //return ;
    updateChatSome( +st.value.uuid,  st.value.index , { dateTime: new Date().toLocaleString(),loading: false })
    //scrollToBottom();
    emit('finished');

    homeStore.setMyData({act:'scrollToBottomIfAtBottom'});
    mlog('🐞 goFinish2',st.value.uuid);
    // setTimeout(() => {

    //    if(textRz.value.length>0 )  textRz.value = [];
    // }, 200 );
}

const getMessage= async (start=1000,loadingCnt=3)=>{
    return getHistoryMessage(dataSources.value,loadingCnt,start);
}
watch( ()=>textRz.value, (n)=>{
    //mlog('🐞 textRz',n);
    if(n.length==0) return ;
    updateChatSome( +st.value.uuid, st.value.index , { dateTime: new Date().toLocaleString(),text: n.join('') })
    //scrollToBottom();
    homeStore.setMyData({act:'scrollToBottomIfAtBottom'})
    //homeStore.setMyData({act:'scrollToBottom'})
},{deep:true})
const { uuid } = useRoute().params as { uuid: string }
watch(()=>homeStore.myData.act, async (n)=>{

    if(n=='gpt.submit' ||  n=='gpt.whisper'  ){

        const dd:any = homeStore.myData.actData;

        let  uuid2 =  dd.uuid?? uuid;
        st.value.uuid =  uuid2 ;
        st.value.chatType = dd.chatType;
        st.value.appId = dd.appId??'';
        const chatSet = new chatSetting(   +st.value.uuid  );
        const nGptStore =   chatSet.getGptConfig();
         mlog('gpt.submit', dd , dd.uuid,  nGptStore ) ;
        let model = nGptStore.model ;//gptConfigStore.myData.model

        if(checkDisableGpt4( model )){
            ms.error( t('mj.disableGpt4') );
            return false;
        }

        let promptMsg = getInitChat(dd.prompt );
        if( dd.fileBase64 && dd.fileBase64.length>0 ){
            if( !canVisionModel(model)  ) model='gpt-image';

            try{
                    let images= await localSaveAny( JSON.stringify( dd.fileBase64)  ) ;
                    mlog('key', images );
                    promptMsg.opt= {images:[images]}
            }catch(e){
                mlog('localSaveAny error',e);
            }
        }
        if( n=='gpt.whisper'){
            //model='whisper-1';
            try{
                let bb= await file2blob( dd.file );
                // bb.blob
                let lkey = await localSaveAny( bb   ) ;
                mlog('key', lkey );
                promptMsg.opt= { lkey  }
                promptMsg.text='Loading...'
                promptMsg.model='whisper-1';
                if(dd.duration && dd.duration>0 ){
                     promptMsg.text=`${t('mj.lang')} ${dd.duration.toFixed(2)}s`;
                }
                addChat(  +uuid2, promptMsg );
                homeStore.setMyData({act:'scrollToBottom'});
            }catch(e){
                mlog('localSaveAny error',e);
                ms.error( t('mj.noSupperChrom') );
                return ;
            }

            try{
                const formData = new FormData( );
                formData.append('file',dd.file );
                formData.append('model', 'whisper-1');
                const whisper=  await whisperUpload( formData);
                mlog('whisper 内容>> ', whisper );
                let opt={duration:0,...promptMsg.opt };
                opt.duration= dd.duration??0;
                updateChatSome(  +uuid2, dataSources.value.length-1, {text:whisper.text,opt } );
                dd.prompt= whisper.text;
                //return ;
            }catch(e){
                updateChatSome(  +uuid2, dataSources.value.length-1, {text:`${t('mj.fail')}：${e}` } );
                return ;
            }

        }else{
            addChat(  +uuid2, promptMsg );
            homeStore.setMyData({act:'scrollToBottom'});
        }

        let outMsg: Chat.Chat={
            dateTime: new Date().toLocaleString(),
            text: t('mj.thinking') ,//'思考中...',
            loading: true,
            inversion: false,
            error: false,
            conversationOptions: null,
            requestOptions: { prompt: dd.prompt, options: {  } },
            uuid:+uuid2,
            model ,
            myid: `${Date.now()}`
        }
        // if(gptConfigStore.myData.gpts){
        //     outMsg.logo= gptConfigStore.myData.gpts.logo ;
        // }
        //  const chatSet = new chatSetting(   +st.value.uuid  );
        // const nGptStore =   chatSet.getGptConfig()  ;
        //chatSet
        if( nGptStore.gpts ){
            outMsg.logo= nGptStore.gpts.logo ;
        }
        addChat(  +uuid2, outMsg  )
        st.value.index= dataSources.value.length - 1;
        if(textRz.value.length>=0) textRz.value = [ ];

        homeStore.setMyData({act:'scrollToBottom'})
        let historyMesg=  await getMessage();
        mlog('historyMesg', historyMesg );
        //return ;
        // let message= [ {  "role": "system", "content": getSystemMessage(  +uuid2) },
        //         ...historyMesg ];
        let message= [...historyMesg ];

        // 处理文件（支持新的uploadedFiles和原有的fileBase64）
        let hasFiles = (dd.fileBase64 && dd.fileBase64.length > 0) || (dd.uploadedFiles && dd.uploadedFiles.length > 0);
        
        // 暂时禁用文档解析功能，避免后端编译错误
        let documentContents = "";
        if (dd.uploadedFiles && dd.uploadedFiles.length > 0) {
            // 获取支持解析的文档
            const supportedDocs = dd.uploadedFiles.filter((file:any) => 
                file.fileType !== 'image' && isSupportedDocument(file.extension)
            );
            
            if (supportedDocs.length > 0) {
                console.log("文档解析功能暂时禁用，等待后端修复");
                // 暂时跳过文档解析，直接显示文件信息
            }
        }
        
        if(hasFiles){
            // 添加详细的调试信息
            console.log('=== AI图片识别调试信息 ===');
            console.log('当前使用的模型:', model);
            console.log('模型名称类型:', typeof model);
            console.log('模型名称长度:', model?.length);
            console.log('模型名称小写:', model?.toLowerCase());
            console.log('模型是否包含deepseek:', model?.indexOf('deepseek') > -1);
            console.log('模型是否包含qwen:', model?.indexOf('qwen') > -1);
            console.log('canVisionModel判断结果:', canVisionModel(model));
            console.log('isCanBase64Model判断结果:', isCanBase64Model(model));
            
            // 🚨 紧急修复：如果检测到自研模型且上传了图片，强制启用多模态支持
            const isCustomModel = model?.toLowerCase().includes('自研') || 
                                 model?.toLowerCase().includes('custom') ||
                                 model?.toLowerCase().includes('混合') ||
                                 (model?.toLowerCase().includes('deepseek') && model?.toLowerCase().includes('qwen')) ||
                                 model?.toLowerCase().includes('deep') ||
                                 model?.toLowerCase().includes('qw');
            
            console.log('🚨 是否为自研模型:', isCustomModel);
            
            // 强制支持模式：如果是自研模型就强制支持多模态
            const forceSupport = isCustomModel && (dd.fileBase64?.length > 0 || dd.uploadedFiles?.filter((f:any) => f.fileType === 'image').length > 0);
            console.log('🚨 强制支持多模态模式:', forceSupport);
            console.log('是否有图片文件:', dd.fileBase64?.length > 0 || dd.uploadedFiles?.filter((f:any) => f.fileType === 'image').length > 0);
            console.log('fileBase64数组:', dd.fileBase64);
            console.log('uploadedFiles数组:', dd.uploadedFiles);
            
            if(isCanBase64Model(model) || forceSupport){
                console.log('✅ 使用多模态消息格式发送图片');
                if(forceSupport) console.log('🚨 通过强制支持模式启用多模态');
                // 支持多模态的模型（如GPT-4V）
                let obj={
                        "role": "user" as const,
                       "content": [] as any
                }
                // 构建完整的文本内容
                let fullPrompt = dd.prompt;
                
                // 如果有解析的文档内容，添加到prompt前面
                if (documentContents && documentContents.trim()) {
                    fullPrompt = "【文档内容】：\n" + documentContents + "\n\n【用户问题】：\n" + dd.prompt;
                }
                
                obj.content.push({ "type": "text", "text": fullPrompt });
                
                // 处理原有的图片（兼容旧格式）
                if(dd.fileBase64 && dd.fileBase64.length > 0){
                    dd.fileBase64.forEach((f:any)=>{
                        console.log('🖼️ 处理图片（兼容格式）');
                        
                        if (f.startsWith('data:image/')) {
                            // 🎯 Base64格式图片（推荐）
                            console.log('✅ 检测到Base64格式图片，直接发送');
                            console.log('📋 Base64长度:', f.length);
                            obj.content.push({ "type": "image_url", "image_url": {url: f } });
                        } else {
                            // URL格式图片（需要转换）
                            let imageUrl = f;
                            if (imageUrl.startsWith('/uploads/')) {
                                imageUrl = window.location.origin + imageUrl;
                            }
                            console.log('⚠️ 使用URL格式图片（可能无法访问）:', imageUrl);
                            
                            // 验证URL可访问性
                            const testImg = new Image();
                            testImg.onload = () => console.log('✅ 图片URL可以正常访问（兼容格式）');
                            testImg.onerror = () => console.log('❌ 图片URL无法访问（兼容格式）');
                            testImg.src = imageUrl;
                            
                            obj.content.push({ "type": "image_url", "image_url": {url: imageUrl } });
                        }
                    });
                }
                
                // 处理新的上传文件（仅图片和不支持解析的文件显示链接）
                if(dd.uploadedFiles && dd.uploadedFiles.length > 0){
                    dd.uploadedFiles.forEach((file:any)=>{
                        if(file.fileType === 'image'){
                            console.log('🖼️ 处理图片文件:', file.originalName);
                            
                            // 🚨 优先使用Base64编码（如果可用）
                            if (file.base64) {
                                console.log('✅ 使用Base64编码发送图片（更可靠）');
                                console.log('📋 Base64长度:', file.base64.length);
                                obj.content.push({ 
                                    "type": "image_url", 
                                    "image_url": { url: file.base64 } 
                                });
                            } else {
                                // 备用方案：使用URL
                                let imageUrl = file.url;
                                if (imageUrl.startsWith('/uploads/')) {
                                    imageUrl = window.location.origin + imageUrl;
                                }
                                console.log('⚠️ 使用URL发送图片（可能无法访问）:', imageUrl);
                                
                                // 验证URL可访问性
                                const testImg = new Image();
                                testImg.onload = () => console.log('✅ 图片URL可以正常访问');
                                testImg.onerror = () => console.log('❌ 图片URL无法访问，建议重新上传');
                                testImg.src = imageUrl;
                                
                                obj.content.push({ 
                                    "type": "image_url", 
                                    "image_url": { url: imageUrl } 
                                });
                            }
                        } else if (!isSupportedDocument(file.extension)) {
                            // 不支持解析的文件显示链接信息
                            obj.content.push({ 
                                "type": "text", 
                                "text": `\n📎 文件: ${file.originalName} (${file.extension.toUpperCase()}) \n🔗 链接: ${file.url}\n` 
                            });
                        }
                        // 支持解析的文档内容已经包含在documentContents中，不再重复显示链接
                    });
                }
                
                message.push(obj);
            }else{
                console.log('❌ 使用文本格式发送文件信息（模型不支持多模态）');
                // 不支持多模态的模型，将文件信息添加到文本中
                let cc= dd.prompt;
                
                // 如果有解析的文档内容，优先使用解析内容
                if (documentContents && documentContents.trim()) {
                    cc = "【文档内容】：\n" + documentContents + "\n\n【用户问题】：\n" + dd.prompt;
                } else {
                    // 处理原有的图片
                    if(dd.fileBase64 && dd.fileBase64.length > 0){
                        let arr = dd.fileBase64.filter( (ff:string)=>ff.indexOf('http')>-1);
                        if(arr.length>0) cc = arr.join(' ')+' '+ cc ;
                    }
                    
                    // 处理不支持解析的文件
                    if(dd.uploadedFiles && dd.uploadedFiles.length > 0){
                        let unsupportedFiles = dd.uploadedFiles.filter((file:any) => 
                            file.fileType === 'image' || !isSupportedDocument(file.extension)
                        );
                        
                        if (unsupportedFiles.length > 0) {
                            let fileInfo = unsupportedFiles.map((file:any) => {
                                return `📎 ${file.originalName} (${file.extension.toUpperCase()}, ${formatFileSize(file.fileSize)}): ${file.url}`;
                            }).join('\n');
                            cc = fileInfo + '\n\n' + cc;
                        }
                    }
                }
                
                message.push({  "role": "user" as const,  "content": cc })
            }
        }else{
            message.push({  "role": "user" as const,  "content": dd.prompt })
        }
        
        // 调试：打印最终发送给AI的消息
        console.log('发送给AI的消息:', JSON.stringify(message[message.length - 1], null, 2));
        
        let opt={};
        if( n=='gpt.whisper'){
            opt= {
                file: dd.file
            }
        }

        submit(model,message,opt);

    }else if(n=='abort'){
       controller.value && controller.value.abort();
    }else if(n=='gpt.resubmit'){
        //  if(checkDisableGpt4(gptConfigStore.myData.model)){
        //     ms.error( t('mj.disableGpt4') );
        //     return false;
        // }
        const dd:any = homeStore.myData.actData;
        let  uuid2 =  dd.uuid?? uuid;
        st.value.uuid =  uuid2 ;
        st.value.index = +dd.index;

        mlog('gpt.resubmit', dd  ) ;
        let historyMesg= await  getMessage( (+dd.index)-1,1  ); //
        mlog('gpt.resubmit historyMesg', historyMesg );
        let nobj = dataSources.value[ dd.index ];
        //mlog('gpt.resubmit model', nobj.model  );
        let model = nobj.model as string

        if(checkDisableGpt4(  model )){
            ms.error( t('mj.disableGpt4') );
            return false;
        }
        //return ;
        if(['whisper-1','midjourney'].indexOf(model)>-1){
            ms.error( t('mj.noSuppertModel') );
            return;
        }

        controller.value = new AbortController();
        let message= [ {  "role": "system", "content": getSystemMessage(+st.value.uuid ) },
                ...historyMesg ];
        textRz.value=[];

        submit(model, message);

    }else if(n=='gpt.ttsv2'){
        const actData:any = homeStore.myData.actData;
        mlog('gpt.ttsv2',actData );
        st.value.index= actData.index;
        st.value.uuid= actData.uuid;
        ms.info( t('mj.ttsLoading'));
        const chatSet = new chatSetting(   +st.value.uuid  );
        const nGptStore =   chatSet.getGptConfig()  ;

        subTTS({model:'tts-1',input: actData.text , voice:nGptStore.tts_voice }).then(d=>{
                ms.success( t('mj.ttsSuccess'));
                mlog('subTTS',d );
                //d.player.play();
                //textRz.value.push('ok');
                updateChatSome( +st.value.uuid,  st.value.index
                , {
                dateTime: new Date().toLocaleString(),loading: false

                ,opt:{duration:d.duration,lkey:d.saveID }
                });
               // goFinish();
                setTimeout(() => {
                    homeStore.setMyData({act:'playtts',actData:{ saveID:d.saveID} });
                }, 100);
            }).catch(e=>{
                let  emsg =   (JSON.stringify(  e.reason? JSON.parse( e.reason ):e,null,2));
                if(e.message!='canceled' && emsg.indexOf('aborted')==-1 ) textRz.value.push("\n"+t('mjchat.failReason')+" \n```\n"+emsg+"\n```\n");
                //goFinish();
            });
    }
})

const submit= (model:string, message:any[],opt?:any)=>{
    mlog('提交Model', model  );
    const chatSet = new chatSetting(   +st.value.uuid  );
    const nGptStore =   chatSet.getGptConfig()  ;
    controller.value = new AbortController();
        if(model=='whisper-1'){

            //mlog('whisper-12323',opt  );
            const formData = new FormData( );
            formData.append('file', opt.file );
            formData.append('model', 'whisper-1');

            //GptUploader('/v1/audio/transcriptions',formData).then(r=>{
            whisperUpload( formData).then(r=>{
                //mlog('语音识别成功', r );
                textRz.value.push(r.text);
                goFinish();
            }).catch(e=>{
                let emsg =( ( e.message?? JSON.stringify(e)) );
                textRz.value.push("\n"+t('mj.failOcr')+":\n```\n"+emsg+"\n```\n");
                goFinish();
            });
            return ;
        }
        else if( isTTS(model)){
            let text  = message[message.length-1].content;
            mlog('whisper-tts',  message[message.length-1] , text  );
            subTTS({model,input: text, voice:nGptStore.tts_voice }).then(d=>{
                mlog('subTTS',d );
                //d.player.play();
                //textRz.value.push('ok');
                updateChatSome( +st.value.uuid,  st.value.index
                , {
                dateTime: new Date().toLocaleString(),loading: false
                ,text:'ok'
                ,opt:{duration:d.duration,lkey:d.saveID }
                });
                goFinish();
                setTimeout(() => {
                    homeStore.setMyData({act:'playtts',actData:{ saveID:d.saveID} });
                }, 100);
            }).catch(e=>{
                let  emsg =   (JSON.stringify(  e.reason? JSON.parse( e.reason ):e,null,2));
                if(e.message!='canceled' && emsg.indexOf('aborted')==-1 ) textRz.value.push("\n"+t('mjchat.failReason')+" \n```\n"+emsg+"\n```\n");
                goFinish();
            });

        }else{
            subModel( {message, model,
                uuid: st.value.uuid //当前会话
                ,onMessage: (d) => {
                    mlog('🐞消息', d)
                    textRz.value.push(d.text)
                },
                onError: (e: any) => {
                    mlog('onError', e)
                    let emsg = (JSON.stringify(e.reason ? JSON.parse(e.reason) : e, null, 2))
                    //if(emsg=='{}' ) emsg= JSON.stringify(e );
                    if (e.message != 'canceled' && emsg.indexOf('aborted') == -1) textRz.value.push("\n" + t('mjchat.failReason') + "\n```\n" + emsg + "\n```\n")
                    goFinish()
                },
                signal: controller.value.signal,
                kid: '',
                chatType: st.value.chatType,
                appId: st.value.appId
            }).then(()=>goFinish() ).catch(e=>{
                if(e.message!='canceled')  textRz.value.push("\n"+t('mj.fail')+":\n```\n"+(e.reason??JSON.stringify(e,null,2)) +"\n```\n")
                goFinish();
            });
        }
}

homeStore.setMyData({isLoader:false});
</script>
<template>

</template>
