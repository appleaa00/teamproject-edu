package org.ruoyi.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Web配置类
 * 
 * @author AI
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 添加静态资源映射，使上传的图片可以通过URL访问
        // 使用固定的项目根目录绝对路径
        String uploadsPath = "file:C:/Users/28279/Desktop/SourceCode/uploads/";
        
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(uploadsPath);
    }
}
