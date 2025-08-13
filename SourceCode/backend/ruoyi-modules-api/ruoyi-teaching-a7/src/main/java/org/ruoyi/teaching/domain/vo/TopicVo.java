package org.ruoyi.teaching.domain.vo;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.ruoyi.teaching.domain.Topic;
import org.ruoyi.teaching.domain.bo.TopicOptionBo;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = Topic.class)
public class TopicVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 题目名称
     */
    private String topicName;

    /**
     * 题目难度
     */
    private String topicDifficulty;

    /**
     * 题目类型
     */
    private String topicType;

    /**
     * 题目内容
     */
    private String topicContent;

    /**
     * 参考答案
     */
    private String topicAnswer;

    /**
     * 收藏
     */
    private Boolean collection;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 如果是选择题，需要选项的，则需要保存题目选项
     */
    private List<TopicOptionVo> topicOptions;

    /**
     * 返回当前用户回答的答案
     */
    private String topicWrite;
    /**
     * 返回当前用户回答的答案
     */
    private Boolean rightAnswer;
}