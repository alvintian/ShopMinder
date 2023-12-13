import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), reminder: Reminder(title: "Sample Reminder", time: Date()))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, reminder: Reminder(title: "Sample Reminder", time: Date()))
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let sampleReminder = Reminder(title: "Buy Milk", time: currentDate.addingTimeInterval(60 * 60)) // Example reminder

        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, reminder: sampleReminder)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
struct Reminder {
    var title: String
    var time: Date
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let reminder: Reminder
}
struct Reminder_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Reminder: \(entry.reminder.title)")
            Text("Time: \(entry.reminder.time, style: .time)")
        }
    }
}

@main
struct Reminder_widget: Widget {
    let kind: String = "Reminder_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Reminder_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
