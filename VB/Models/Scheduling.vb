Imports Microsoft.VisualBasic
Imports System.Linq
Imports System.Collections
Imports DevExpress.Web.Mvc

Namespace SchdulerBestPracticesMvc.Models
	Public Class SchedulerDataObject
		Private privateAppointments As IEnumerable
		Public Property Appointments() As IEnumerable
			Get
				Return privateAppointments
			End Get
			Set(ByVal value As IEnumerable)
				privateAppointments = value
			End Set
		End Property
		Private privateResources As IEnumerable
		Public Property Resources() As IEnumerable
			Get
				Return privateResources
			End Get
			Set(ByVal value As IEnumerable)
				privateResources = value
			End Set
		End Property
	End Class

	Public Class SchedulerDataHelper
		Public Shared Function GetResources() As IEnumerable
			Dim db As New SchedulingDataClassesDataContext()
			Return _
				From res In db.Cars _
				Select res
		End Function

		Public Shared Function GetAppointments() As IEnumerable
			Dim db As New SchedulingDataClassesDataContext()
			Return _
				From apt In db.CarSchedulings _
				Select apt
		End Function

		Public Shared ReadOnly Property DataObject() As SchedulerDataObject
			Get
				Return New SchedulerDataObject() With {.Appointments = GetAppointments(), .Resources = GetResources()}
			End Get
		End Property

		Public Shared Sub InsertAppointment(ByVal appt As CarScheduling)
			If appt Is Nothing Then
				Return
			End If
			Dim db As New SchedulingDataClassesDataContext()
			appt.ID = appt.GetHashCode()
			db.CarSchedulings.InsertOnSubmit(appt)
			db.SubmitChanges()
		End Sub

		Public Shared Sub UpdateAppointment(ByVal appt As CarScheduling)
			If appt Is Nothing Then
				Return
			End If
			Dim db As New SchedulingDataClassesDataContext()
			Dim query As CarScheduling = CType(( _
						From carSchedule In db.CarSchedulings _
						Where carSchedule.ID = appt.ID _
						Select carSchedule).SingleOrDefault(), CarScheduling)

			query.ID = appt.ID
			query.StartTime = appt.StartTime
			query.EndTime = appt.EndTime
			query.AllDay = appt.AllDay
			query.Subject = appt.Subject
			query.Description = appt.Description
			query.Location = appt.Location
			query.RecurrenceInfo = appt.RecurrenceInfo
			query.ReminderInfo = appt.ReminderInfo
			query.Status = appt.Status
			query.EventType = appt.EventType
			query.Label = appt.Label
			query.CarId = appt.CarId
			db.SubmitChanges()
		End Sub

		Public Shared Sub RemoveAppointment(ByVal appt As CarScheduling)
			Dim db As New SchedulingDataClassesDataContext()
			Dim query As CarScheduling = CType(( _
						From carSchedule In db.CarSchedulings _
						Where carSchedule.ID = appt.ID _
						Select carSchedule).SingleOrDefault(), CarScheduling)
			db.CarSchedulings.DeleteOnSubmit(query)
			db.SubmitChanges()
		End Sub
	End Class
End Namespace