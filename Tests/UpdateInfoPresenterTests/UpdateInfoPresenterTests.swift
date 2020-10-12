import XCTest
@testable import UpdateInfoPresenter

final class UpdateInfoPresenterTests: XCTestCase {
    let target = 3
    let testCases: [
        (
            option: UpdateInfoPresenter.PresentOption,
            childCases: [(input: (previous: Int?, current: Int), expected: Bool)]
        )
    ] = [
        (
            option: .empty,
            childCases: [
                (input: (previous: nil, current: 2), expected: false),
                (input: (previous: nil, current: 3), expected: false),
                (input: (previous: nil, current: 4), expected: false),
                (input: (previous: 1, current: 0), expected: false),
                (input: (previous: 1, current: 1), expected: false),
                (input: (previous: 1, current: 2), expected: false),
                (input: (previous: 1, current: 3), expected: true),
                (input: (previous: 1, current: 4), expected: false),
                (input: (previous: 3, current: 2), expected: false),
                (input: (previous: 3, current: 3), expected: false),
                (input: (previous: 3, current: 4), expected: false),
                (input: (previous: 4, current: 2), expected: false),
                (input: (previous: 4, current: 3), expected: false),
                (input: (previous: 4, current: 4), expected: false),
                (input: (previous: 4, current: 5), expected: false),
            ]
        ),
        (
            option: .newUser,
            childCases: [
                (input: (previous: nil, current: 2), expected: false),
                (input: (previous: nil, current: 3), expected: true),
                (input: (previous: nil, current: 4), expected: false),
                (input: (previous: 1, current: 0), expected: false),
                (input: (previous: 1, current: 1), expected: false),
                (input: (previous: 1, current: 2), expected: false),
                (input: (previous: 1, current: 3), expected: true),
                (input: (previous: 1, current: 4), expected: false),
                (input: (previous: 3, current: 2), expected: false),
                (input: (previous: 3, current: 3), expected: false),
                (input: (previous: 3, current: 4), expected: false),
                (input: (previous: 4, current: 2), expected: false),
                (input: (previous: 4, current: 3), expected: false),
                (input: (previous: 4, current: 4), expected: false),
                (input: (previous: 4, current: 5), expected: false),
            ]
        ),
        (
            option: .skippedUser,
            childCases: [
                (input: (previous: nil, current: 2), expected: false),
                (input: (previous: nil, current: 3), expected: false),
                (input: (previous: nil, current: 4), expected: false),
                (input: (previous: 1, current: 0), expected: false),
                (input: (previous: 1, current: 1), expected: false),
                (input: (previous: 1, current: 2), expected: false),
                (input: (previous: 1, current: 3), expected: true),
                (input: (previous: 1, current: 4), expected: true),
                (input: (previous: 3, current: 2), expected: false),
                (input: (previous: 3, current: 3), expected: false),
                (input: (previous: 3, current: 4), expected: false),
                (input: (previous: 4, current: 2), expected: false),
                (input: (previous: 4, current: 3), expected: false),
                (input: (previous: 4, current: 4), expected: false),
                (input: (previous: 4, current: 5), expected: false),
            ]
        ),
        (
            option: [.newUser, .skippedUser],
            childCases: [
                (input: (previous: nil, current: 2), expected: false),
                (input: (previous: nil, current: 3), expected: true),
                (input: (previous: nil, current: 4), expected: true),
                (input: (previous: 1, current: 0), expected: false),
                (input: (previous: 1, current: 1), expected: false),
                (input: (previous: 1, current: 2), expected: false),
                (input: (previous: 1, current: 3), expected: true),
                (input: (previous: 1, current: 4), expected: true),
                (input: (previous: 3, current: 2), expected: false),
                (input: (previous: 3, current: 3), expected: false),
                (input: (previous: 3, current: 4), expected: false),
                (input: (previous: 4, current: 2), expected: false),
                (input: (previous: 4, current: 3), expected: false),
                (input: (previous: 4, current: 4), expected: false),
                (input: (previous: 4, current: 5), expected: false),
            ]
        )
    ]
    
    func test() {
        for testCase in testCases {
            let (option, childCases) = testCase
            for childCase in childCases {
                let (input, expected) = childCase
                let got = option.needsPresent(target: target, previous: input.previous, current: input.current)
                XCTAssertEqual(
                    got,
                    expected,
                    "option: \(option), input: \(input), expected: \(expected), got: \(got)"
                )
            }
        }
        
    }

    static var allTests = [
        ("test", test),
    ]
}
