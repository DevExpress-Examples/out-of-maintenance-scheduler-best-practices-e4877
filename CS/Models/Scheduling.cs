using System.Linq;
using System.Collections;
using DevExpress.Web.Mvc;

namespace SchdulerBestPracticesMvc.Models {
    public class SchedulerDataObject {
        public IEnumerable Appointments { get; set; }
        public IEnumerable Resources { get; set; }
    }

    public class SchedulerDataHelper {
        public static IEnumerable GetResources() {
            SchedulingDataClassesDataContext db = new SchedulingDataClassesDataContext();
            return from res in db.Cars select res;
        }

        public static IEnumerable GetAppointments() {
            SchedulingDataClassesDataContext db = new SchedulingDataClassesDataContext();
            return from apt in db.CarSchedulings select apt;
        }

        public static SchedulerDataObject DataObject {
            get {
                return new SchedulerDataObject() {
                    Appointments = GetAppointments(),
                    Resources = GetResources()
                };
            }
        }

        public static void InsertAppointment(CarScheduling appt) {
            if (appt == null)
                return;
            SchedulingDataClassesDataContext db = new SchedulingDataClassesDataContext();
            appt.ID = appt.GetHashCode();
            db.CarSchedulings.InsertOnSubmit(appt);
            db.SubmitChanges();
        }

        public static void UpdateAppointment(CarScheduling appt) {
            if (appt == null)
                return;
            SchedulingDataClassesDataContext db = new SchedulingDataClassesDataContext();
            CarScheduling query = (CarScheduling)(from carSchedule in db.CarSchedulings where carSchedule.ID == appt.ID select carSchedule).SingleOrDefault();

            query.ID = appt.ID;
            query.StartTime = appt.StartTime;
            query.EndTime = appt.EndTime;
            query.AllDay = appt.AllDay;
            query.Subject = appt.Subject;
            query.Description = appt.Description;
            query.Location = appt.Location;
            query.RecurrenceInfo = appt.RecurrenceInfo;
            query.ReminderInfo = appt.ReminderInfo;
            query.Status = appt.Status;
            query.EventType = appt.EventType;
            query.Label = appt.Label;
            query.CarId = appt.CarId;
            db.SubmitChanges();
        }

        public static void RemoveAppointment(CarScheduling appt) {
            SchedulingDataClassesDataContext db = new SchedulingDataClassesDataContext();
            CarScheduling query = (CarScheduling)(from carSchedule in db.CarSchedulings where carSchedule.ID == appt.ID select carSchedule).SingleOrDefault();
            db.CarSchedulings.DeleteOnSubmit(query);
            db.SubmitChanges();
        }
    }
}