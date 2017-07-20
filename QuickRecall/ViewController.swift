//
//  ViewController.swift
//  QuickRecall
//
//  Created by Nathaniel Hatfield on 5/29/17.
//  Copyright © 2017 Nathaniel Hatfield. All rights reserved.
//
//  Sound effects by Bertrof at https://freesound.org/people/Bertrof/

import UIKit
import Speech
import AudioToolbox

class ViewController: UIViewController, SFSpeechRecognizerDelegate, AVSpeechSynthesizerDelegate {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var correctOrIncorrectLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var testButton: UIButton!
    
    
    let questionProvider = QuestionProvider()
    var currentQuestion: Question = Question("", [""])
    var questionNumber: Int = 1
    var playerAnswer = ""
    var countdownTimer: Timer!
    var totalTime = 3
    let questionReader = QuestionReader()
    
    enum QuestionState {
        case beforeStarted
        case beforeBuzzed
        case afterBuzzed
    }
    
    var practiceStarted = QuestionState.beforeStarted
    
    var speechSynthesizer = AVSpeechSynthesizer()
    var currentUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "")
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var soundPlayer : AVAudioPlayer?
    
    func playSound(_ sound: String){
        let path = Bundle.main.path(forResource: sound, ofType:"wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            self.soundPlayer = sound
            sound.numberOfLoops = 0
            sound.prepareToPlay()
            sound.play()
        } catch {
            print("error loading file")
            // couldn't load file :(
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Round the corners of the player's speech bubble
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        
        
        // Round the corners of the timer label
        timerLabel.frame = CGRect(x: 40, y: 40, width: 48, height: 48)
        timerLabel.layer.cornerRadius = 0.5 * timerLabel.bounds.size.width
        timerLabel.clipsToBounds = true
        
        currentQuestion = questionProvider.randomQuestion()
        questionLabel.text = "Question \(questionNumber): \(currentQuestion.clue)"
        questionReader.newUtterance(from: questionLabel.text!)
        
        microphoneButton.isEnabled = false
        speechRecognizer.delegate = self
        speechSynthesizer.delegate = self
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func answerQuestion(_ sender: UIButton) {
        
        currentQuestion = questionProvider.randomQuestion()
        questionNumber += 1
        questionLabel.text = "Question \(questionNumber): \(currentQuestion.clue)"
        
    }
    
    @IBAction func microphoneTapped(_ sender: AnyObject) {
        
        if practiceStarted == .beforeStarted {
            
            microphoneButton.setTitle("BUZZ", for: .normal)
            questionReader.read()
            //if questionLabel.isHidden == true {
                //questionLabel.isHidden = false
            //}
            
            practiceStarted = .beforeBuzzed
            return
        } else if practiceStarted == .afterBuzzed {
            updateQuestion()
            correctOrIncorrectLabel.isHidden = true
            practiceStarted = .beforeBuzzed
            microphoneButton.setTitle("BUZZ", for: .normal)
            return
        } else if practiceStarted == .beforeBuzzed {
            
            //questionReader.read()
            practiceStarted = .afterBuzzed
            
        }
        
        if questionReader.isReading() == true {
            questionReader.stopReading()
        }
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            microphoneButton.isEnabled = false
            microphoneButton.setTitle("Start Recording", for: .normal)
            endTimer()
        } else {
            startRecording()
            microphoneButton.setTitle("Stop Recording", for: .normal)
            startTimer()
        }
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.textView.text = result?.bestTranscription.formattedString
                self.playerAnswer = self.textView.text
                isFinal = (result?.isFinal)!
                
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        textView.text = "Please speak your answer!"
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microphoneButton.isEnabled = true
        } else {
            microphoneButton.isEnabled = false
        }
    }
    
    func startTimer() {
        
        microphoneButton.isEnabled = false
        
        if timerLabel.isHidden == true {
            timerLabel.isHidden = false
        }
        if textView.isHidden == true {
            textView.isHidden = false
        }
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        totalTime = 3
        audioEngine.stop()
        recognitionRequest?.endAudio()
        microphoneButton.isEnabled = false
        microphoneButton.setTitle("NEXT", for: .normal)
        if correctOrIncorrectLabel.isHidden == true {
            correctOrIncorrectLabel.isHidden = false
        }
        switch self.currentQuestion.checkAnswer(for: self.playerAnswer) {
            case true:
                self.correctOrIncorrectLabel.text = "Correct!"
                self.playSound("correct")
            case false:
                self.correctOrIncorrectLabel.text = "Incorrect"
                self.playSound("incorrect")
            print(textView.text)
        }
        
        practiceStarted = QuestionState.afterBuzzed
        microphoneButton.isEnabled = true
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        //let minutes: Int = (totalSeconds / 60) % 60
        //let hours: Int = totalSeconds / 3600
        return String(format: "%02d", seconds)
    }
    
    func updateQuestion() {
        currentQuestion = questionProvider.randomQuestion()
        questionNumber += 1
        questionLabel.text = "Question \(questionNumber): \(currentQuestion.clue)"
        questionReader.newUtterance(from: questionLabel.text!)
        questionReader.read()
        
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
    }
    
    
}

