import type {
  DeptTree,
  ResetPwdParam,
  Paper,
  UserImportParam,
  ModelInfoResponse,
} from './model';

import type { ID, IDS, PageQuery, PageResult } from '#/api/common';

import { commonExport, ContentTypeEnum } from '#/api/helper';
import { requestClient } from '#/api/request';

enum Api {
  root = '/a7/paper',
  paperList = '/a7/paper/list',
  saveAnswer = '/a7/paper/saveAnswer',
  deptTree = '/system/user/deptTree',
  listDeptUsers = '/system/user/list/dept',
  userAuthRole = '/system/user/authRole',
  userExport = '/system/user/export',
  userImport = '/system/user/importData',
  userImportTemplate = '/system/user/importTemplate',
  userResetPassword = '/system/user/resetPwd',
  userStatusChange = '/system/user/changeStatus',
}

/**
 *  获取用户列表
 * @param params
 * @returns User
 */
export function findList(params?: PageQuery) {
  return requestClient.get<PageResult<Paper>>(Api.paperList, { params });
}

/**
 * 导出excel
 * @param data data
 * @returns blob
 */
export function userExport(data: Partial<Paper>) {
  return commonExport(Api.userExport, data);
}

/**
 * 从excel导入用户
 * @param data
 * @returns void
 */
export function userImportData(data: UserImportParam) {
  return requestClient.post<{ code: number; msg: string }>(
    Api.userImport,
    data,
    {
      headers: {
        'Content-Type': ContentTypeEnum.FORM_DATA,
      },
      isTransformResponse: false,
    },
  );
}

/**
 * 下载用户导入模板
 * @returns blob
 */
export function downloadImportTemplate() {
  return requestClient.post<Blob>(
    Api.userImportTemplate,
    {},
    {
      isTransformResponse: false,
      responseType: 'blob',
    },
  );
}

/**
 * 可以不传ID  返回部门和角色options 需要获得原始数据
 * 不传ID时一定要带最后的/
 * @param userId 用户ID
 * @returns 用户信息
 */
export function findModel(id?: ID) {
  const url = id ? `${Api.root}/${id}` : `${Api.root}/`;
  return requestClient.get<ModelInfoResponse>(url);
}

export function saveAnswer(id?: ID, data: any) {
  const url = `${Api.saveAnswer}/${id}`;
  return requestClient.postWithMsg<void>(url, data);
}

/**
 * 新增
 * @param data data
 * @returns void
 */
export function paperAdd(data: Partial<Paper>) {
  return requestClient.postWithMsg<void>(Api.root, data);
}

/**
 * 更新用户
 * @param data data
 * @returns void
 */
export function userUpdate(data: Partial<Paper>) {
  return requestClient.putWithMsg<void>(Api.root, data);
}

/**
 * 更新用户状态
 * @param data data
 * @returns void
 */
export function userStatusChange(data: Partial<Paper>) {
  return requestClient.putWithMsg<void>(Api.userStatusChange, data);
}

/**
 * @param id ID
 * @returns void
 */
export function userRemove(id: any) {
  return requestClient.deleteWithMsg<void>(`${Api.root}/${id}`);
}
