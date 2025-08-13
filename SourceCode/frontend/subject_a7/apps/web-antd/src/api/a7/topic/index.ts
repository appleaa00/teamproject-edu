import type {
  DeptTree,
  ResetPwdParam,
  Topic,
  UserImportParam,
  TopicInfoResponse,
} from './model';

import type { ID, IDS, PageQuery, PageResult } from '#/api/common';

import { commonExport, ContentTypeEnum } from '#/api/helper';
import { requestClient } from '#/api/request';

enum Api {
  topicList = '/a7/topic/list',
  deptTree = '/system/user/deptTree',
  listDeptUsers = '/system/user/list/dept',
  root = '/a7/topic',
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
export function topicList(params?: PageQuery) {
  return requestClient.get<PageResult<Topic>>(Api.topicList, { params });
}

/**
 * 导出excel
 * @param data data
 * @returns blob
 */
export function userExport(data: Partial<Topic>) {
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
export function findTopic(userId?: ID) {
  const url = userId ? `${Api.root}/${userId}` : `${Api.root}/`;
  return requestClient.get<TopicInfoResponse>(url);
}

/**
 * 新增
 * @param data data
 * @returns void
 */
export function topicAdd(data: Partial<Topic>) {
  return requestClient.postWithMsg<void>(Api.root, data);
}

/**
 * 更新用户
 * @param data data
 * @returns void
 */
export function userUpdate(data: Partial<Topic>) {
  return requestClient.putWithMsg<void>(Api.root, data);
}

/**
 * 更新用户状态
 * @param data data
 * @returns void
 */
export function userStatusChange(data: Partial<Topic>) {
  return requestClient.putWithMsg<void>(Api.userStatusChange, data);
}

/**
 * @param id ID
 * @returns void
 */
export function userRemove(id: any) {
  return requestClient.deleteWithMsg<void>(`${Api.root}/${id}`);
}

/**
 * 重置用户密码 需要加密
 * @param data
 * @returns void
 */
export function userResetPassword(data: ResetPwdParam) {
  return requestClient.putWithMsg<void>(Api.userResetPassword, data, {
    encrypt: true,
  });
}

/**
 * 这个方法未调用过
 * @param userId
 * @returns void
 */
export function getUserAuthRole(userId: ID) {
  return requestClient.get(`${Api.userAuthRole}/${userId}`);
}

/**
 * 这个方法未调用过
 * @param userId
 * @returns void
 */
export function userAuthRoleUpdate(userId: ID, roleIds: number[]) {
  return requestClient.putWithMsg(Api.userAuthRole, { roleIds, userId });
}

/**
 * 获取部门树
 * @returns 部门树数组
 */
export function getDeptTree() {
  return requestClient.get<DeptTree[]>(Api.deptTree);
}

/**
 * 获取部门下的所有用户信息
 */
export function listUserByDeptId(deptId: ID) {
  return requestClient.get<Topic[]>(`${Api.listDeptUsers}/${deptId}`);
}
