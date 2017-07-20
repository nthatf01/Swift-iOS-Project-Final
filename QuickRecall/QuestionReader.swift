//
//  QuestionReader.swift
//  QuickRecall
//
//  Created by Nathaniel Hatfield on 7/18/17.
//  Copyright © 2017 Nathaniel Hatfield. All rights reserved.
//

import Foundation
import Speech

class QuestionReader {
    let speechSynthesizer = AVSpeechSynthesizer()
    var currentUtterance = AVSpeechUtterance()

    func newUtterance(from textString: String) {
        currentUtterance = AVSpeechUtterance(string: textString)
    }
    
    func read() {
        speechSynthesizer.speak(currentUtterance)
    }
    
    func pause() {
        self.speechSynthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    func unpause() {
        self.speechSynthesizer.continueSpeaking()
    }
    
    func stopReading() {
        self.speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    func isReading() -> Bool {
        if speechSynthesizer.isSpeaking == true {
            return true
        } else {
            return false
        }
    }
}
