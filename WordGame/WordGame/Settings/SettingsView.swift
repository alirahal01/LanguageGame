//
//  SettingsView.swift
//  WordGame
//
//  Created by ali rahal on 30/04/2023.
//

import Foundation

import SwiftUI

struct SettingsView: View {
    @AppStorage("numberOfQuestions") var numberOfQuestions = 6
    @AppStorage("roundTime") var roundTime = 6
    @AppStorage("appearance") var appearance: Appearance = .automatic
    @AppStorage("dailyReminderEnabled") var dailyReminderEnabled = false
    @State var dailyReminderTime = Date(timeIntervalSince1970: 0)
    @AppStorage("dailyReminderTime") var dailyReminderTimeShadow: Double = 0
    @AppStorage("questionCardBackgroundColor") var questionCardBackgroundColorInt: Int = 0xFF0000FF
    @State var questionCardBackgroundColor: Color = .red
    @AppStorage("answerCardBackgroundColor") var answerCardBackgroundColorInt: Int = 0xFF0000FF
    @State var answerCardBackgroundColor: Color = .red
    
    var body: some View {
        List {
            Text("Settings")
                .font(.largeTitle)
                .padding(.bottom, 8)
            
            Section(header: Text("Appearance")) {
                VStack(alignment: .leading) {
                    Picker("", selection: $appearance) {
                        ForEach(Appearance.allCases) { appearance in
                            Text(appearance.name).tag(appearance)
                        }          }
                    .pickerStyle(SegmentedPickerStyle())
                    Spacer(minLength: 10)
                    ColorPicker(
                        "Question Crad Background Color",
                        selection: $questionCardBackgroundColor
                    )
                    Spacer(minLength: 10)
                    ColorPicker(
                        "Answer Card Background Color",
                        selection: $answerCardBackgroundColor
                    )
                    Spacer(minLength: 10)
                }
            }
            
            Section(header: Text("Game")) {
                VStack(alignment: .leading) {
                    Stepper(
                        "Number of Questions: \(numberOfQuestions)",
                        value: $numberOfQuestions,
                        in: 3 ... 20
                    )
                    Text("Any change will affect the next game")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Stepper(
                        "Round Time: \(roundTime)",
                        value: $roundTime,
                        in: 0 ... 10
                    )
                    Text("Any change will affect the next game")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            Section(header: Text("Notifications")) {
                HStack {
                    Toggle("Daily Reminder", isOn: $dailyReminderEnabled)
                    DatePicker("", selection: $dailyReminderTime, displayedComponents: .hourAndMinute)
                }
            }
            .onChange(of: dailyReminderEnabled, perform: { _ in configureNotification() })
            .onChange(of: dailyReminderTime, perform: { newValue in
                dailyReminderTimeShadow = newValue.timeIntervalSince1970
                configureNotification()
            })
            .onChange(of: questionCardBackgroundColor, perform: { newValue in
                questionCardBackgroundColorInt = newValue.asRgba
            })
            .onChange(of: answerCardBackgroundColor, perform: { newValue in
                answerCardBackgroundColorInt = newValue.asRgba
            })
            .onAppear {
                dailyReminderTime = Date(timeIntervalSince1970: dailyReminderTimeShadow)
                questionCardBackgroundColor = Color(rgba: questionCardBackgroundColorInt)
            }
        }
    }
    
    func configureNotification() {
        if dailyReminderEnabled {
            LocalNotifications.shared.createReminder(time: dailyReminderTime)
        } else {
            LocalNotifications.shared.deleteReminder()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
