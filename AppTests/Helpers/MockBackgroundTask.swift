// MockBackgroundTask.swift
// Copyright (C) 2020 Presidenza del Consiglio dei Ministri.
// Please refer to the AUTHORS file for more information.
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

//
// MockBackgroundTask.swift
// Immuni
//
// Copyright © 2020 Bending Spoons S.p.a. All rights reserved.
// Created by Immuni Team.
//
import Foundation
@testable import Immuni

class MockBackgroundTask: BackgroundTask {
  var setTaskCompletedMethodCalls: [Bool] = []

  var expirationHandler: (() -> Void)?

  func setTaskCompleted(success: Bool) {
    self.setTaskCompletedMethodCalls.append(success)
  }
}