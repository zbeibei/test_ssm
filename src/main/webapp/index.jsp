<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/11/15
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        application.setAttribute("APP_PATH",request.getContextPath());
    %>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.3.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工添加信息，Modal -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="beibei@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-4">
                            <%--部门提供部门的id即可，通过获取数据库内容进行填充--%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工修改信息，Modal -->
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myUpdateModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myUpdateModalLabel">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_update_static" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static" ></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="beibei@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept_update_select" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-4">
                            <%--部门提供部门的id即可，通过获取数据库内容进行填充--%>
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all"></th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>


                </tbody>
            </table>
        </div>
    </div>

    <!-- 显示分页信息 -->
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_info_area"></div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
    <script type="text/javascript">
        var total_record,currentPage;
        // 1. 页面加载完成后，直接发送ajax请求
        $(function () {
            toPage(1);
        })

        function toPage(pn) {
            $.ajax({
                //请求的地址
                url:"${APP_PATH}/emps",
                //  请求的数据
                data:"pn="+pn,
                //    请求的类型
                type:"get",
                //    请求成功的回调函数
                success:function (result) {
                    // console.log(result);
                    // 1. 解析并显示员工数据
                    build_emps_table(result);
                    // 2. 解析并显示分页信息
                    build_page_info(result);

                    build_page_nav(result);

                }

            })
        }

        function build_emps_table(result) {
            //清空table表格的数据
            $("#emps_table tbody").empty();
            var emps=result.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                // alert(item.empName);
                var checkbox=$("<td><input type='checkbox' class='check_item'/></td>")
                var empIdTd=$("<td></td>").append(item.empId);
                var empNameTd=$("<td></td>").append(item.empName);
                var gender=item.gender=='M'?"男":"女";
                var empGenderTd=$("<td></td>").append(gender);
                var empEmailTd=$("<td></td>").append(item.email);
                var deptNameTd=$("<td></td>").append(item.department.deptName);
            // <button class="btn btn-primary btn-sm">
            //         <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
            //     编辑
            //     </button>
            //     <button class="btn btn-danger btn-sm">
            //         <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
            //     删除
            //     </button>
            //    编辑
                var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>")).addClass("glyphicon glyphicon-pencil").append("编辑");
                //自定义属性，获取id
                editBtn.attr("edit_id",item.empId);
                //删除
                var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>")).addClass("glyphicon glyphicon-trash").append("删除");
                //自定义删除属性的id
                delBtn.attr("del_id",item.empId);
                var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
                //单个append
                $("<tr></tr>")
                    .append(checkbox)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(empGenderTd)
                    .append(empEmailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            })

        }

        //解析分页信息
        function build_page_info(result) {
            //清空分页显示信息
            $("#page_info_area").empty();
            var pageInfo=result.extend.pageInfo;
            $("#page_info_area").append("当前"+pageInfo.pageNum+"页,总" +
                pageInfo.pages+"页,总"+pageInfo.total+"条记录");
            total_record=pageInfo.total;
            currentPage=pageInfo.pageNum;
        }

        //解析分页条
        function build_page_nav(result) {
            //清空分页条信息
            $("#page_nav_area").empty();

            var ul=$("<ul></ul>").addClass("pagination");
            //构建元素
            var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi=$("<li></li>").append($("<a></a>").append("<span><span>").append("&laquo;"));
            //如果有首页或前一页
            if(result.extend.pageInfo.hasPreviousPage==false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加翻页事件
                firstPageLi.click(function () {
                    toPage(1);
                })

                prePageLi.click(function () {
                    toPage(result.extend.pageInfo.pageNum-1);
                })
            }

            //构建元素
            var nextPageLi=$("<li></li>").append($("<a></a>").append("<span><span>").append("&raquo;"));
            var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if(result.extend.pageInfo.hasNextPage==false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function () {
                    toPage(result.extend.pageInfo.pageNum+1);
                })

                lastPageLi.click(function () {
                    toPage(result.extend.pageInfo.pages);
                })
            }


            //添加首页和前一页
            ul.append(firstPageLi).append(prePageLi);
            //index为索引,item为当前元素
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
                var numLi=$("<li></li>").append($("<a></a>").append("<span><span>").append(item));

                //给当前页添class为active
                if(item==result.extend.pageInfo.pageNum){
                    numLi.addClass("active");
                }
                //单页添加点击事件
                numLi.click(function () {
                    toPage(item);
                })
                //添加分页条
                ul.append(numLi);
            })
            //添加下一页和末页
            ul.append(nextPageLi).append(lastPageLi);

            var navEle=$("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        //清空表单样式和数据
        function reset_form(ele){
            //清空数据
            $(ele)[0].reset();
        //    清空表单样式
            $(ele).find("*").removeClass("has-success has-error");
            $(ele).find(".help-block").text("");

        }

        //点新增按钮弹出模态框
        $("#emp_add_model_btn").click(function () {
            //清除表单数据(表单重置，数据和样式)
            // $("#empAddModel form")[0].reset();
            reset_form("#empAddModel form");
            //发送ajax请求，查出部门信息
            getDepts("#empAddModel select");
            //弹出模态框
            $("#empAddModel").modal({
                backdrop:"static"

            })
        })

        function getDepts(ele) {
            //清空下拉列表数据
            $(ele).empty();
            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                success:function (result) {
                    // extend: {depts: [{deptId: 1, deptName: "开发部"}, {deptId: 2, deptName: "开发部"}, {deptId: 3, deptName: "开发部"},…]}
                    // msg: "返回成功"
                    // $("#dept_add_select").append("")
                    $.each(result.extend.depts,function () {
                        var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                        optionEle.appendTo(ele);
                    })

                }

            })
        }

        function validate_add_form(){
        //    1.拿到数据，使用正则
            var empName=$("#empName_add_input").val();
            //正则
            var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            // alert(regName.test(empName));
            if(!regName.test(empName)){
                // alert("用户名可为2-5位中文或6-16位英文");
                show_validate_msg("#empName_add_input","error","用户名可为2-5位中文或6-16位英文");
                // $("#empName_add_input").parent().addClass("has-error");
                // $("#empName_add_input").next("span").text("用户名可为2-5位中文或6-16位英文");
                return false;
            }else {
                show_validate_msg("#empName_add_input","success","")
                // $("#empName_add_input").parent().addClass("has-success");
                // $("#empName_add_input").next("span").text("");
            }

            var email=$("#email_add_input").val();
            var regEmail=/^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
            if(!regEmail.test(email)){
                // alert("邮箱格式不正确");
                show_validate_msg("#email_add_input","error","邮箱格式不正确")
                // $("#email_add_input").parent().addClass("has-error");
                // $("#email_add_input").next("span").text("邮箱格式不正确");
                return false;
            }else {
                show_validate_msg("#email_add_input","success","");
                // $("#email_add_input").parent().addClass("has-success");
                // $("#email_add_input").next("span").text("");
            }

            return true;

        }

        //校验信息
        function show_validate_msg(ele,status,msg){
            //清楚当前元素原有class
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if("success"==status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text("");
            }else {
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }

        }
        //change时间表示状态框改变时
        $("#empName_add_input").change(function () {
        //    发送ajax检查用户名是否可用
            var empName=this.value;
            $.ajax({
                url:"${APP_PATH}/checkuser",
                data:"empName="+empName,
                type:"POST",
                success:function (result) {
                    if(result.code==100){
                        show_validate_msg("#empName_add_input","success","用户名可用");
                        $("#emp_save_btn").attr("ajax-va","success");
                    }else {
                        show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va","error");
                    }
                }
            })

        })

        //点击保存员工信息
        $("#emp_save_btn").click(function () {
        //1.模态框中填写表单数据发送到服务器
        //    对提交的数据进行校验
            if(!validate_add_form()){
                return false;
            }
        //判断之间的ajax判断用户名的是否通过，若通过则发送请求
            if(($(this).attr("ajax-va"))=="error"){
                return false;
            }

        //2发搜ajax请求保存员工
        //     alert($("#empAddModel form").serialize());
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                //发送给服务的数据，拿表单里面的数据
                data:$("#empAddModel form").serialize(),
                success:function (result) {
                    //返回验证信息
                    // alert(result.msg);
                    if(result.code==100){
                        // 1.关闭模态框
                        $("#empAddModel").modal("hide");
                        //    2. 到最后一页
                        //    发送ajax显示最后一页数据,可为最大数
                        //    其二可为总记录数
                        toPage(total_record);
                    }else {
                        // console.log(result);
                        if(undefined !=result.extend.errorFieldMap.email){
                        //    显示邮箱错误信息
                            show_validate_msg("#email_add_input","error",result.extend.errorFieldMap.email)
                        }
                        if(undefined != result.extend.errorFieldMap.empName){
                            show_validate_msg("#empName_add_input","error",result.extend.errorFieldMap.empName);
                        }


                    }
                }
            })

        })

        //绑定事件，
        //因为使用jquery时先绑定各种事件之后在添加元素
        //jquery新版没有live，使用on
        // $(".edit_btn").click(function () {
        //     alert("edit");
        // })
        //1. 点击click绑定事件，on命令可以在为之后的元素添加事件
        //2. 查出部门信息，部门列表
        //3. 查出员工信息，显示员工信息
        $(document).on("click",".edit_btn",function () {
            // alert("edit");
            //查询部门信息
            getDepts("#empUpdateModel select");
            //查询员工信息
            getEmp($(this).attr("edit_id"));

            //员工id传递给模态框更细按钮
            $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
            $("#empUpdateModel").modal({
                backdrop:"static"

            })

        })

        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                    var empEle=result.extend.emp;
                    $("#empName_update_static").text(empEle.empName);
                    $("#email_update_input").val(empEle.email);
                    $("#empUpdateModel input[name=gender]").val([empEle.gender]);
                    $("#empUpdateModel select").val([empEle.dId]);

                }
            })
        }
    //    点击更新员工信息
    $("#emp_update_btn").click(function () {
        //1.邮箱验证
        var email=$("#email_update_input").val();
        var regEmail=/^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if(!regEmail.test(email)){
            // alert("邮箱格式不正确");
            show_validate_msg("#email_update_input","error","邮箱格式不正确")
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式不正确");
            return false;
        }else {
            show_validate_msg("#email_update_input","success","");
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("");
        }
        // 2.发送ajax，保存
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
            type:"PUT",
            //带的数据
            data:$("#empUpdateModel form").serialize(),
            success:function (result) {
                // alert(result.msg);
                // 1.关闭模态框
                $("#empUpdateModel").modal("hide");
                //    2. 回到本页面
                toPage(currentPage);
            }
        })
    })

        // 单个删除
        $(document).on("click",".delete_btn",function () {
        //    1.弹出是否删除
        //     alert($(this).parents("tr").find("td:eq(1)").text());
            var empName=$(this).parents("tr").find("td:eq(2)").text();
            var empId=$(this).attr("del_id");
            if(confirm("确认删除【"+empName+"】吗？")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        toPage(currentPage);
                    }
                })
            }

        })

    //    完成全选、全部选
        $("#check_all").click(function () {
        //    attr获取checked是undefined
        //    prop获取原生dom值，attr获取自定义的值
            $(".check_item").prop("checked",$(this).prop("checked"));
        })
    //    check_item是之后创建的，所以需要加on
        $(document).on("click",".check_item",function () {
            //当前选中的item个数
            if(($(".check_item:checked").length)==$(".check_item").length){
                $("#check_all").prop("checked",true);
            }else {
                $("#check_all").prop("checked",false);
            }
            // var flag=$(".check_item:checked").length==$(".check_item").length;
            // alert(flag);
            // $("#check_all").prop("checked",flag);
            // $("#check_all").prop("checked",)

        })

    //    点击全部删除
        $("#emp_delete_all_btn").click(function () {

        //    遍历每一个check选框
            var empNames="";
            //拿到id的值，用于连接
            var del_idstr="";
            $.each($(".check_item:checked"),function () {
                // alert($(this).parents("tr").find("td:eq(2)").text());
            //    拿到员工的值
                empNames +=$(this).parents("tr").find("td:eq(2)").text()+",";
                del_idstr +=$(this).parents("tr").find("td:eq(1)").text()+"-";
            })
            //去年名字多余的，
            empNames=empNames.substring(0,empNames.length-1);
            //取出id多余的-
            del_idstr=del_idstr.substring(0,del_idstr.length-1);
            if(confirm("确认删除【"+empNames+"】吗？")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        toPage(currentPage);
                    }

                })
            }
        })
    </script>


</body>
</html>
