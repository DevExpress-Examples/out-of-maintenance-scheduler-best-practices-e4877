<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/128553467/13.1.6%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/E4877)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
<!-- default badges end -->
<!-- default file list -->
*Files to look at*:

* [SchedulerHelper.cs](./CS/Code/SchedulerHelper.cs) (VB: [SchedulerHelper.vb](./VB/Code/SchedulerHelper.vb))
* [HomeController.cs](./CS/Controllers/HomeController.cs) (VB: [HomeController.vb](./VB/Controllers/HomeController.vb))
* [Scheduling.cs](./CS/Models/Scheduling.cs) (VB: [Scheduling.vb](./VB/Models/Scheduling.vb))
* [Index.cshtml](./CS/Views/Home/Index.cshtml)
* [SchedulerPartial.cshtml](./CS/Views/Home/SchedulerPartial.cshtml)
<!-- default file list end -->
# Scheduler - Best practices


<p>This example illustrates the most reliable approach to define the <a href="https://documentation.devexpress.com/#AspNet/CustomDocument11675">Scheduler</a> extension in your MVC application with the capability to perform CRUD operations. <br /><br />The main principal is isolation of extension settings. They are isolated to a separate <strong>SchedulerHelper</strong> class. The SchedulerPartial view and SchedulerExtension.GetAppointmentTo* methods (e.g., <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebMvcSchedulerExtension_GetAppointmentsToInsert[T]topic(UK6dZw)">SchedulerExtension.GetAppointmentsToInsert</a>) use it. It is mandatory for scenarios when CRUD operations are required (e.g., see <a href="https://documentation.devexpress.com/#AspNet/CustomDocument11629">Lesson 3 - Use Scheduler in Complex Views</a> ). Moreover, it is good practice to always use this design because it guarantees reliable extension operation. Note that it is applicable for other extensions such as GridView (see <a href="https://www.devexpress.com/Support/Center/p/T191698">T191698 - How to isolate extension settings into separate helper class and share a single partial view to display multiple extensions</a>), HtmlEditor (see <a href="https://www.devexpress.com/Support/Center/p/T280805">T280805: HtmlEditor - Insert media content buttons are disabled</a>), etc. <br /><br />In addition, we define the <strong>SchedulerHelper.CreateSchedulerSettings</strong> method as an extension method (e.g., see <a href="https://msdn.microsoft.com/en-us/library/vstudio/bb311042.aspx">How to: Implement and Call a Custom Extension Method</a>) for the HtmlHelper class. This allows us to access HtmlHelper facilities in the extension method (by default, they are available in the View context only). The  <a href="https://www.devexpress.com/Support/Center/p/T191698">T191698 - How to isolate extension settings into separate helper class and share a single partial view to display multiple extensions</a> code example illustrates a more universal approach (the WebViewPage class is used instead of the HtmlHelper class).</p>

<br/>


