package top.beibei.service;/**
 * @Author: Zbeibei
 * @Date: Created in 2018/11/15 20:27
 * @Descrption:
 */

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.beibei.beans.Employee;
import top.beibei.beans.EmployeeExample;
import top.beibei.dao.EmployeeMapper;

import java.util.List;

/**
 * @Author: lenovo
 * @Date: 2018/11/15 20:27
 * @Desc:
 */
//业务逻辑主键，service层
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);

    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

//    检验用户名
    public boolean checkuser(String empName) {
        EmployeeExample employeeExample=new EmployeeExample();
        EmployeeExample.Criteria criteria= employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count= employeeMapper.countByExample(employeeExample);

        return count==0;

    }

    /**
     * 按id查询员工
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee= employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 更新员工信息
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);

    }

    /**
     * 删除员工
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }


    public void deleteBatch(List<Integer> ids) {
        EmployeeExample employeeExample=new EmployeeExample();
        EmployeeExample.Criteria criteria= employeeExample.createCriteria();
//        delete form xxx where id in(1,2,3)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample);

    }
}
