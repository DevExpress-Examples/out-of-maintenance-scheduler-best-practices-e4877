Imports Microsoft.VisualBasic
Imports DevExpress.Web.Mvc
Imports SchdulerBestPracticesMvc.Code
Imports SchdulerBestPracticesMvc.Models
Imports System.Web.Mvc

Namespace SchdulerBestPracticesMvc
	Public Class HomeController
		Inherits Controller
		Public Function Index() As ActionResult
			Return View(SchedulerDataHelper.DataObject)
		End Function

		Public Function SchedulerPartial() As ActionResult
			Return PartialView("SchedulerPartial", SchedulerDataHelper.DataObject)
		End Function

		Public Function EditAppointment() As ActionResult
			UpdateAppointment()
			Return PartialView("SchedulerPartial", SchedulerDataHelper.DataObject)
		End Function

		Private Shared Sub UpdateAppointment()
			Dim insertedAppt As CarScheduling = SchedulerExtension.GetAppointmentToInsert(Of CarScheduling)(SchedulerHelper.Settings, SchedulerDataHelper.GetAppointments(), SchedulerDataHelper.GetResources())
			SchedulerDataHelper.InsertAppointment(insertedAppt)

			Dim updatedAppt() As CarScheduling = SchedulerExtension.GetAppointmentsToUpdate(Of CarScheduling)(SchedulerHelper.Settings, SchedulerDataHelper.GetAppointments(), SchedulerDataHelper.GetResources())
			For Each appt In updatedAppt
				SchedulerDataHelper.UpdateAppointment(appt)
			Next appt

			Dim removedAppt() As CarScheduling = SchedulerExtension.GetAppointmentsToRemove(Of CarScheduling)(SchedulerHelper.Settings, SchedulerDataHelper.GetAppointments(), SchedulerDataHelper.GetResources())
			For Each appt In removedAppt
				SchedulerDataHelper.RemoveAppointment(appt)
			Next appt
		End Sub
	End Class
End Namespace