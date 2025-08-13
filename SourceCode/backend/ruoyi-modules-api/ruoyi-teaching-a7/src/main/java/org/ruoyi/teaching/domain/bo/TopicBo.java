package org.ruoyi.teaching.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;
import org.ruoyi.teaching.domain.Topic;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serial;
import java.util.Date;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = Topic.class, reverseConvertGenerate = false)
public class TopicBo extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 试卷ID
     */
    private Long paperId;

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
     * 创建时间查询
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startCreateTime;

    /**
     * 如果是选择题，需要选项的，则需要保存题目选项
     */
    private List<TopicOptionBo> topicOptions;
}