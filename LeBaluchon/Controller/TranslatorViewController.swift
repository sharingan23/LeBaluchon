//
//  TranslatorViewController.swift
//  LeBaluchon
//
//  Created by Vigneswaranathan Sugeethkumar on 07/01/2019.
//  Copyright © 2019 Vigneswaranathan Sugeethkumar. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController, UITextViewDelegate {
   
    //Outlet text
    @IBOutlet weak var firstText: UITextView!
    @IBOutlet weak var secondText: UITextView!
    //Outlet Language
    @IBOutlet weak var sourceLang: UIImageView!
    @IBOutlet weak var targetLang: UIImageView!
    //Variable who use to compare if source lang is french
    var compareFrenchLang = UIImage(named: "france")
    // Instance of translater
    var translater = Translate(translateSession: URLSession(configuration: .default))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstText.delegate = self
        
    }

    func textViewDidChange(_ textView: UITextView) {
        checkSourceLang()
    }
    
    //translate text from firstText into targetLang
    func getTranslate(sourceLang: String,targetLang: String){
        translater.getText(withText: firstText.text, targetLanguage: targetLang, sourceLanguage: sourceLang) { (translator, error) in
            if let translator = translator {
                self.secondText.text = translator.data!.translations[0]!.translatedText
                
            }
        }
    }
    
    
    func checkSourceLang(){
        if sourceLang.image!.isEqual(compareFrenchLang) {
            print("true")
            getTranslate(sourceLang: "fr", targetLang: "eng")
        } else  {
            print("false")
            getTranslate(sourceLang: "eng", targetLang: "fr")
        }
        
        
    }
    
    @IBAction func changeSourceLang(_ sender: Any) {
        let sourceText = firstText.text
        if sourceLang.image!.isEqual(compareFrenchLang) {
            sourceLang.image = UIImage(named: "us")
            targetLang.image = UIImage(named: "france")
            firstText.text = secondText.text
            secondText.text = sourceText
        } else{
            sourceLang.image = UIImage(named: "france")
            targetLang.image = UIImage(named: "us")
            firstText.text = secondText.text
            secondText.text = sourceText
        }
    }
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        firstText.resignFirstResponder()
        secondText.resignFirstResponder()
    }
    
}
