package org.ruoyi.teaching.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;
import org.ruoyi.teaching.domain.Paper;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serial;
import java.util.Date;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = Paper.class, reverseConvertGenerate = false)
public class PaperBo extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 题目名称
     */
    private String paperName;

    /**
     * 当前试卷是什么角色的人创建的
     */
    private String createRole;

    /**
     * 创建人姓名
     */
    private String createName;

    /**
     * 测验难度（基础、中等、挑战）
     */
    private String paperDifficulty;

    /**
     * 试卷类型
     */
    private String paperType;

    /**
     * 科目
     */
    private String paperSubject;

    /**
     * 题目数量
     */
    private Integer topicNumber;

    /**
     * 考试时间（单位：分钟）
     */
    private Integer answerTime;

    /**
     * 收藏
     */
    private Boolean collection;

    /**
     * 开始创建时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startCreateTime;

    /**
     * 结束创建时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endCreateTime;

    /**
     * 题目保存
     */
    private List<TopicBo> topics;
}