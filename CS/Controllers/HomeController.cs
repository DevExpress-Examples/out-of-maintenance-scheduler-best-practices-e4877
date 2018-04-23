using DevExpress.Web.Mvc;
using SchdulerBestPracticesMvc.Code;
using SchdulerBestPracticesMvc.Models;
using System.Web.Mvc;

namespace SchdulerBestPracticesMvc {
    public class HomeController: Controller {
        public ActionResult Index() {
            return View(SchedulerDataHelper.DataObject);
        }

        public ActionResult SchedulerPartial() {
            return PartialView("SchedulerPartial", SchedulerDataHelper.DataObject);
        }

        public ActionResult EditAppointment() {
            UpdateAppointment();
            return PartialView("SchedulerPartial", SchedulerDataHelper.DataObject);
        }

        static void UpdateAppointment() {
            CarScheduling insertedAppt = SchedulerExtension.GetAppointmentToInsert<CarScheduling>(
                SchedulerHelper.Settings,
                SchedulerDataHelper.GetAppointments(),
                SchedulerDataHelper.GetResources()
            );
            SchedulerDataHelper.InsertAppointment(insertedAppt);

            CarScheduling[] updatedAppt = SchedulerExtension.GetAppointmentsToUpdate<CarScheduling>(
                SchedulerHelper.Settings,
                SchedulerDataHelper.GetAppointments(),
                SchedulerDataHelper.GetResources()
            );
            foreach (var appt in updatedAppt) {
                SchedulerDataHelper.UpdateAppointment(appt);
            }

            CarScheduling[] removedAppt = SchedulerExtension.GetAppointmentsToRemove<CarScheduling>(
                SchedulerHelper.Settings,
                SchedulerDataHelper.GetAppointments(),
                SchedulerDataHelper.GetResources()
            );
            foreach (var appt in removedAppt) {
                SchedulerDataHelper.RemoveAppointment(appt);
            }
        }
    }
}