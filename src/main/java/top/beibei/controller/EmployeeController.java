package top.beibei.controller;/**
 * @Author: Zbeibei
 * @Date: Created in 2018/11/15 20:22
 * @Descrption:
 */

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.executor.ReuseExecutor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import top.beibei.beans.Employee;
import top.beibei.beans.Msg;
import top.beibei.service.EmployeeService;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: lenovo
 * @Date: 2018/11/15 20:22
 * @Desc:
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 单个删除和批量删除合二为一
     * @param ids
     * @return
     */

    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids")String ids){
        if(ids.contains("-")){
//            批量删除，用list集合，传给mapper的andempIdIn方法
            List<Integer> del_ids=new ArrayList<>();
            String[] strings= ids.split("-");
            for(String string:strings){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);

        }else {
            Integer id=Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }

        return Msg.success();
    }

    /**直接发送put请求，并通过HttpPutFormContentFilter封装数据用于ajax提交put方式
     *
     * 员工更新方法
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /**
     * 根据id查询员工
      * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id){
        Employee employee= employeeService.getEmp(id);

        return Msg.success().add("emp",employee);
    }

    /**
     * 检查用户名是否重复
     * @param empName
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkuser(@RequestParam("empName")String empName){
//        判断用户名是否合法
        String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)) {
            return Msg.fail().add("va_msg","用户名必须为6-16位数字和字母的组合或2-5位中文");
        }

//        校验重复性
        boolean ckUser= employeeService.checkuser(empName);
        if(ckUser){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    /**
     * 员工保存
     * 1、支持jsr303校验
     * 2、导入hibernat-Validator
     * valid 校验后台的数据，result返回结果数据
     * @param employee
     * @return
     */

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){

            Map<String,Object> map=new HashMap<String, Object>();
//            检验失败，返回失败
            List<FieldError> errors= result.getFieldErrors();
            for(FieldError fieldError:errors){
//                System.out.println("错误字段信息："+fieldError.getField());
//                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }

            return Msg.fail().add("errorFieldMap",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    /**
     * 用Json返回类型处理数据
     * 导入jackson包处理
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
//        startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emp= employeeService.getAll();

        //用PageInfo对结果进行包装,可查询所有页面信息
//        封装了详细的分页信息,包括查询出的数据，pageInfo参数中传入list和连续显示的页数
        PageInfo page = new PageInfo(emp,5);
        return Msg.success().add("pageInfo",page);

    }

    /**
     * 查询员工数据（分页）
     * @return
     */
    //@RequestMapping("/emps")
    public String employList(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
//        引入PageHelper分页插件
//        查询之前只需要调用,传入页码和每页的大小
        PageHelper.startPage(pn,5);
//        startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emp= employeeService.getAll();

        //用PageInfo对结果进行包装,可查询所有页面信息
//        封装了详细的分页信息,包括查询出的数据，pageInfo参数中传入list和连续显示的页数
        PageInfo page = new PageInfo(emp,5);
        model.addAttribute("pageInfo",page);

        return "list";
    }

}
