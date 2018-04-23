Imports Microsoft.VisualBasic
Imports System
Imports System.Web.Mvc
Imports System.Web.Mvc.Html
Imports DevExpress.Web.Mvc
Imports DevExpress.Web.Mvc.UI

Namespace SchdulerBestPracticesMvc.Code
	Public Module SchedulerHelper
        Private settings_Renamed As SchedulerSettings

        Public ReadOnly Property Settings() As SchedulerSettings
            Get
                If settings_Renamed Is Nothing Then
                    settings_Renamed = CreateSchedulerSettings(Nothing)
                End If
                Return settings_Renamed
            End Get
        End Property

        <System.Runtime.CompilerServices.Extension()> _
        Public Function CreateSchedulerSettings(ByVal htmlHelper As HtmlHelper) As SchedulerSettings
            Dim settings As New SchedulerSettings()
            settings.Name = "scheduler"
            settings.CallbackRouteValues = New With {Key .Controller = "Home", Key .Action = "SchedulerPartial"}
            settings.EditAppointmentRouteValues = New With {Key .Controller = "Home", Key .Action = "EditAppointment"}

            settings.Storage.Appointments.Assign(DefaultAppointmentStorage)
            settings.Storage.Resources.Assign(DefaultResourceStorage)

            settings.Storage.Appointments.ResourceSharing = True
            settings.Start = New DateTime(2008, 7, 11)
            Return settings
        End Function

        Private defaultAppointmentStorage_Renamed As MVCxAppointmentStorage
        Public ReadOnly Property DefaultAppointmentStorage() As MVCxAppointmentStorage
            Get
                If defaultAppointmentStorage_Renamed Is Nothing Then
                    defaultAppointmentStorage_Renamed = CreateDefaultAppointmentStorage()
                End If
                Return defaultAppointmentStorage_Renamed
            End Get
        End Property
        Private Function CreateDefaultAppointmentStorage() As MVCxAppointmentStorage
            Dim appointmentStorage As New MVCxAppointmentStorage()
            appointmentStorage.Mappings.AppointmentId = "ID"
            appointmentStorage.Mappings.Start = "StartTime"
            appointmentStorage.Mappings.End = "EndTime"
            appointmentStorage.Mappings.Subject = "Subject"
            appointmentStorage.Mappings.Description = "Description"
            appointmentStorage.Mappings.Location = "Location"
            appointmentStorage.Mappings.AllDay = "AllDay"
            appointmentStorage.Mappings.Type = "EventType"
            appointmentStorage.Mappings.RecurrenceInfo = "RecurrenceInfo"
            appointmentStorage.Mappings.ReminderInfo = "ReminderInfo"
            appointmentStorage.Mappings.Label = "Label"
            appointmentStorage.Mappings.Status = "Status"
            appointmentStorage.Mappings.ResourceId = "CarId"
            Return appointmentStorage
        End Function

        Private defaultResourceStorage_Renamed As MVCxResourceStorage
        Public ReadOnly Property DefaultResourceStorage() As MVCxResourceStorage
            Get
                If defaultResourceStorage_Renamed Is Nothing Then
                    defaultResourceStorage_Renamed = CreateDefaultResourceStorage()
                End If
                Return defaultResourceStorage_Renamed
            End Get
        End Property
        Private Function CreateDefaultResourceStorage() As MVCxResourceStorage
            Dim resourceStorage As New MVCxResourceStorage()
            resourceStorage.Mappings.ResourceId = "ID"
            resourceStorage.Mappings.Caption = "Model"
            Return resourceStorage
        End Function
	End Module
End Namespace