package top.beibei.test;/**
 * @Author: Zbeibei
 * @Date: Created in 2018/11/13 19:51
 * @Descrption:
 */


import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import top.beibei.beans.Department;
import top.beibei.beans.Employee;
import top.beibei.dao.DepartmentMapper;
import top.beibei.dao.EmployeeMapper;

import java.util.UUID;

/**
 * spring的单元测试，自动注入需要的组件
 * 1. 导入SpringTest模块
 * 2. @ContextConfiguration指定spring配置文件的位置
 * 3. 通过RunWith(SpringJUnit4ClassRunner.class)解析test运行
 * 4. 使用autowired自动加载需要的组件
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext-dao.xml",})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){

//        1.插入几个部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));

//        2.生成员工数据，
//       employeeMapper.insertSelective(new Employee(null,"beibei","M","beibei@163.cm",1));

//       3.批量插入多个员工，批量！
//        sqlSession执行批量动作
//        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
//        int i;
//        for(i=0; i<1000; i++){
//            String uuid=UUID.randomUUID().toString().substring(0,5)+i;
//            mapper.insertSelective(new Employee(null,uuid,"M",uuid+"@163.com",1));
//        }


    }
}
