// SuggestionsUITests.swift
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

import Models
import TempuraTesting
import XCTest

@testable import Immuni

class SuggestionsUITests: AppViewTestCase, ViewTestCase {
  typealias V = SuggestionsView

  let mockedToday = CalendarDay(year: 2020, month: 2, day: 28)
  let mockedLastContact = CalendarDay(year: 2020, month: 3, day: 04)

  var neutralVM: SuggestionsVM {
    return SuggestionsVM(
      today: self.mockedToday,
      covidStatus: .neutral,
      isHeaderVisible: false
    )
  }

  var neutralWithHeaderVM: SuggestionsVM {
    return SuggestionsVM(
      today: self.mockedToday,
      covidStatus: .neutral,
      isHeaderVisible: true
    )
  }

  var riskVM: SuggestionsVM {
    return SuggestionsVM(
      today: self.mockedToday,
      covidStatus: .risk(lastContact: self.mockedLastContact),
      isHeaderVisible: false
    )
  }

  var riskWithHeaderVM: SuggestionsVM {
    return SuggestionsVM(
      today: self.mockedToday,
      covidStatus: .risk(lastContact: self.mockedLastContact),
      isHeaderVisible: true
    )
  }

  var positiveVM: SuggestionsVM {
    return SuggestionsVM(
      today: self.mockedToday,
      covidStatus: .positive(lastUpload: self.mockedLastContact),
      isHeaderVisible: false
    )
  }

  var positiveWithHeaderVM: SuggestionsVM {
    return SuggestionsVM(
      today: self.mockedToday,
      covidStatus: .positive(lastUpload: self.mockedLastContact),
      isHeaderVisible: true
    )
  }

  func testUI() {
    self.uiTest(
      testCases: [
        "suggestions_neutral": self.neutralVM,
        "suggestions_risk": self.riskVM,
        "suggestions_positive": self.positiveVM
      ],
      context: UITests.Context<V>()
    )
  }

  func testUIScrolled() {
    let context = UITests.Context<V>(hooks: [
      UITests.Hook.viewDidLayoutSubviews: { view in
        if view.contentCollectionCanScroll {
          view.collection.contentOffset = CGPoint(x: 0, y: view.collection.contentSize.height - view.collection.frame.height)
        } else {
          view.collection.contentOffset = .zero
        }
      }
    ])

    self.uiTest(
      testCases: [
        "suggestions_neutral_scrolled": self.neutralWithHeaderVM,
        "suggestions_risk_scrolled": self.riskWithHeaderVM,
        "suggestions_positive_scrolled": self.positiveWithHeaderVM
      ],
      context: context
    )
  }

  func isViewReady(_ view: SuggestionsView, identifier: String) -> Bool {
    guard identifier.contains("_scrolled") else {
      return true
    }

    view.setNeedsLayout()
    return !view.contentCollectionCanScroll || view.collection.contentOffset.y > 0
  }

  func scrollViewsToTest(in view: SuggestionsView, identifier: String) -> [String: UIScrollView] {
    return [
      "collection": view.collection
    ]
  }
}

// MARK: Helpers

extension SuggestionsView {
  var contentCollectionCanScroll: Bool {
    return self.collection.contentSize.height > self.collection.frame.height
  }
}
