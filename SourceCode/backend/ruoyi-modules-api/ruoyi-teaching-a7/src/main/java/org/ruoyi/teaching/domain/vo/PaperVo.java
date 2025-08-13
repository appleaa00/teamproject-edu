package org.ruoyi.teaching.domain.vo;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.ruoyi.teaching.domain.Paper;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = Paper.class)
public class PaperVo implements Serializable {

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
     * 创建时间
     */
    private Date createTime;


    /**
     * 当前用户 是否完成当前考卷
     */
    private Boolean finished;

    /**
     * 题目列表
     */
    private List<TopicVo> topics;
}