package top.beibei.controller;/**
 * @Author: Zbeibei
 * @Date: Created in 2018/11/25 21:28
 * @Descrption:
 */

/**
 * @Author: lenovo
 * @Date: 2018/11/25 21:28
 * @Desc:
 */

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.beibei.beans.Department;
import top.beibei.beans.Msg;
import top.beibei.service.DepartmentService;

import java.util.List;

/**
 * 处理部门有关请求
 */

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回部门信息
     */

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
//        查出的部门信息
        List<Department> list=departmentService.getDepts();

        return Msg.success().add("depts",list);
    }

}
