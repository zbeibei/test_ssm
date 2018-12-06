package top.beibei.service;/**
 * @Author: Zbeibei
 * @Date: Created in 2018/11/25 21:30
 * @Descrption:
 */

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.beibei.beans.Department;
import top.beibei.dao.DepartmentMapper;

import java.util.List;

/**
 * @Author: lenovo
 * @Date: 2018/11/25 21:30
 * @Desc:
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {

        List<Department> list=departmentMapper.selectByExample(null);
        return list;
    }
}
