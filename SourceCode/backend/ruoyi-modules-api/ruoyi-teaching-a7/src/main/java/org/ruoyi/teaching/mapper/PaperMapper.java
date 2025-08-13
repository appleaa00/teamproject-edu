package org.ruoyi.teaching.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.ruoyi.core.mapper.BaseMapperPlus;
import org.ruoyi.teaching.domain.Paper;
import org.ruoyi.teaching.domain.vo.PaperVo;

/**
 * 试卷Mapper接口
 *
 * @author baoyu
 */
@Mapper
public interface PaperMapper extends BaseMapperPlus<Paper, PaperVo> {

}