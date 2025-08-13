package org.ruoyi.teaching.domain.vo;


import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.ruoyi.teaching.domain.VideoCourse;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = VideoCourse.class)
public class VideoCourseVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 视频名称
     */
    private String videoName;

    /**
     * 视频类型
     */
    private String videoType;

    /**
     * 视频大小
     */
    private Long videoSize;

    /**
     * 视频大小
     */
    private String formattedSize;

    /**
     * 视频时常
     */
    private BigDecimal videoDuration;

    /**
     * 视频时常
     */
    private String formattedDuration;

    /**
     * 收藏
     */
    private Boolean collection;

    /**
     * 创建时间
     */
    private Date createTime;
}
