//
//  QuestionProvider.swift
//  QuickRecall
//
//  Created by Nathaniel Hatfield on 5/29/17.
//  Copyright © 2017 Nathaniel Hatfield. All rights reserved.
//

import Foundation
import GameKit

class Question {
    let clue: String
    var answers: [String] = []
    
    init(_ clue: String, _ answers: [String]) {
        self.clue = clue
        self.answers = answers
    }
    
    func checkAnswer(for playerAnswer: String) -> Bool {
        
        for answer in self.answers {
            if playerAnswer.uppercased() == answer {
                return true
            } 
        }
        
        return false
    }
}

struct QuestionProvider {
    let questions: [Question] = [
        Question("What is the area in square feet of a rectangle with sides measuring 12 inches and 3 feet?", ["3", "3 SQUARE FEET", "THREE", "THREE SQUARE FEET", "3 FT.²"]),
        Question("Dudley wanted to paint his room. The area of the room was 180 square meters. If one gallon of paint covers 60 square meters, how much paint does he need?", ["3 GALLONS", "THREE GALLONS"]),
        Question("What is the earth's galaxy called?", ["MILKY WAY", "MILKY WAY GALAXY", "THE MILKY WAY", "THE MILKY WAY GALAXY"]),
        Question("Shakespeare wrote three basic types of plays. One category was histories. Name the other two.", ["COMEDIES AND TRAGEDIES", "TRAGEDIES AND COMEDIES", "COMEDY AND TRAGEDY", "TRAGEDY AND COMEDY"]),
        Question("These one celled organisms are used in the fermentation process of beer and wine. Name this organism which causes bread to rise.", ["YEAST"]),
        Question("What body of water is the arm of the Arabian Sea lying between Iran and Arabia? This body of water can be entered from the Gulf of Oman through the Strait of Hormuz.", ["PERSIAN GULF", "THE PERSIAN GULF", "PERSIAN GOLF", "THE PERSIAN GOLF"]),
        Question("First and last names, please. Give the pen name of the author of Life on the Mississippi, The Adventures of Tom Sawyer, and The Adventures of Huckleberry Finn.", ["MARK TWAIN"]),
        Question("A certain unknown angle has a supplementary angle that measures 100 degrees. What is the measure of the unknown angle?", ["80 DEGREES", "EIGHTY DEGREES", "80°"]),
        Question("What was the name of the international organization founded after World War I that was a forerunner of the United Nations?", ["LEAGUE OF NATIONS", "THE LEAGUE OF NATIONS"]),
        Question("Identify the American butterfly remarkable not only for its size and coloration, but for its ability to undertake long migrations.", ["MONARCH", "MONARCHS", "MONARCH BUTTERFLY", "MONARCH BUTTERFLIES"]),
        Question("World War One was known as The Great War, or The World War, until what event occurred?", ["WORLD WAR II", "WWII", "WORLD WAR TWO"]),
        Question("Paganini was a great Italian composer and musician. Name either of the two musical instruments on which he excelled.", ["PIANO", "VIOLIN"]),
        Question("Nate and Miranda were tiling a square kitchen floor using tiles measuring 1 foot by 1 foot. If they used 81 tiles, what are the dimensions of the floor?", ["NINE FEET BY NINE FEET", "9' X 9'", "9 X 9", "9 BY 9"]),
        Question("How many states have the Mississippi River as part of their border?", ["10", "TEN"]),
        Question("What is one fourth plus one third?", ["7/12", "SEVEN TWELFTHS", "SEVEN OVER TWELVE", "712", "712s"]),
        Question("In doing research, you may see such phrases as 'see' or 'see also.' What are these phrases that refer you to other topics?", ["CROSS-REFERENCES", "CROSS-REFERENCE", "CROSS REFERENCES", "CROSS REFERENCE"]),
        Question("The atmosphere of the earth is made up of about 20 percent oxygen, 1 percent of trace gases, and 79 percent of what other gas?", ["NITROGEN"]),
        Question("Identify the ancient wind instrument on which the performer blows into a pipe leading to a windbag into which air is squeezed into reed pipes. It is most popular in Scotland.", ["BAGPIPE", "BAGPIPES"]),
        Question("What is the area of a square which has a perimeter of 4 feet?", ["ONE SQUARE FOOT", "ONE FOOT SQUARED"]),
        Question("The Pacific and Atlantic Oceans are the two largest bodies of water on the surface of the Earth. What is the third largest body of water?", ["INDIAN OCEAN", "THE INDIAN OCEAN"]),
        Question("Iron is an example of these substances that keep the body working correctly. They help keep teeth and bones strong and they also maintain muscles. Identify these substances.", ["MINERALS", "MINERAL"]),
        Question("Name the highest court in the United States.", ["SUPREME COURT", "THE SUPREME COURT", "SUPREME"]),
        Question("In what U.S. city is the Willis Tower located?", ["CHICAGO", "CHICAGO, ILLINOIS", "CHICAGO, IL", "CHICAGO ILLINOIS"]),
        Question("Locate the linking verb in the following sentence: Every motion is perfect.", ["IS"]),
        Question("Arrange the following from smallest to largest: one third, one sixth, one fourth, one eighth.", ["1/8, 1/6, 1/4, 1/3", "ONE EIGHTH ONE SIXTH ONE FOURTH ONE THIRD"]),
        Question("These American colonial forces were said to be ready at a moment's notice.  What was the name given to these original American soldiers?", ["MINUTE MEN"]),
        Question("The assassination of Austria's Archduke Franz Ferdinand was the spark that started what war?", ["WORLD WAR I", "WWI", "WORLD WAR ONE", "THE FIRST WORLD WAR", "FIRST WORLD WAR"]),
        Question("Name the pair of fist-sized organs that filter waste products from the bloodstream of humans.", ["KIDNEYS", "THE KIDNEYS"]),
        Question("Name the three primary colors in art", ["RED BLUE YELLOW", "RED, BLUE, YELLOW", "RED BLUE AND YELLOW", "RED, BLUE, AND YELLOW", "RED YELLOW BLUE", "RED, YELLOW, BLUE", "RED YELLOW AND BLUE", "RED, YELLOW, AND BLUE" ,"BLUE RED YELLOW", "BLUE, RED, YELLOW", "BLUE RED AND YELLOW", "BLUE, RED, AND YELLOW", "BLUE YELLOW RED", "BLUE, YELLOW, RED", "BLUE YELLOW AND RED", "BLUE, YELLOW, AND RED", "YELLOW RED BLUE", "YELLOW, RED, BLUE", "YELLOW RED AND BLUE", "YELLOW, RED, AND BLUE", "YELLOW BLUE RED", "YELLOW, BLUE, RED", "YELLOW BLUE AND RED", "YELLOW, BLUE, AND RED"]),
        Question("The House of Burgesses was established in which colony in 1619?", ["VIRGINIA", "VA"]),
        Question("Most people just love February 14th.  What celebration falls on this day?", ["VALENTINE'S", "VALENTINES", "VALENTINE'S DAY", "VALENTINES DAY", "ST. VALENTINE'S", "ST. VALENTINES", "ST. VALENTINE'S DAY", "ST. VALENTINES DAY"]),
        Question("If the store is 2.5 miles from your house, how far would you drive if you made 4 round trips?", ["20 MILES", "TWENTY MILES"]),
        Question("Typical Plains Indians were wanderers, moving from place to place.  What is the name beginning with the letter 'N' given to these Indians who had no fixed location for their village?", ["NOMADS", "NOMAD"]),
        Question("William McKinley, the 25th U.S. President, was born in Ohio.  What is the capital of Ohio?", ["COLUMBUS"]),
        Question("Arnold was a very unpromising child but he grew up to become a very handsome and successful man.  Name the Hans Christian Andersen fairy tale that tells a story similar to Arnold's.", ["UGLY DUCKLING", "THE UGLY DUCKLING"]),
        Question("First and last name please. Name the literary character who was surprised to find another person's footprints on his island beach. He is the title character in a novel by Daniel Defoe.", ["ROBINSON CRUSOE"]),
        Question("How many instruments are there in a string quartet?", ["4", "FOUR"]),
        Question("In Roman mythology, identify the god of fire and metal working. His name also describes the planet of Mr. Spock on the old T.V. show 'Star Trek.'", ["VULCAN"]),
        Question("Some poets enjoy writing poetry which is humorous or funny. Identify the poet who wrote the book of funny poems called WHERE THE SIDEWALK ENDS.", ["SHEL SILVERSTEIN", "SILVERSTEIN"]),
        Question("Near what major city in central Florida beginning with the letter 'O' is Walt Disney World located?", ["ORLANDO", "ORLANDO, FLORIDA", "ORLANDO, FL", "ORLANDO FLORIDA"]),
        Question("Name this mark that looks like a comma but is placed above a word to show possession and to take the place of letters in a contraction?", ["APOSTROPHE", "AN APOSTROPHE", "'"]),
        Question("One-third times the area of the base times the height is the formula for finding the volume of what three-dimensional figure?", ["PYRAMID", "PYRAMIDS", "CONE", "CONES", "PYRAMID AND CONE", "PYRAMIDS AND CONES", "CONE AND PYRAMID", "CONES AND PYRAMIDS"]),
        Question("What is the area of a square which has a perimeter of 16 feet?", ["16 FT.²", "16 SQUARE FEET", "SIXTEEN SQUARE FEET", "SIXTEEN FEET SQUARED"]),
        Question("A kind of animal group in which each member has a different job is known by what name? Ants live in this type of group.", ["COLONY", "COLONIES", "A COLONY"]),
        Question("He was a famous artist who painted elongated figures and used deep contrasting colors. Identify the artist whose name means 'the Greek.'", ["EL GRECO", "EL GRECO DOMENIKOS< THEOTOKOPOULOS"]),
        Question("John measured the radius of a circle and found it to be 8 inches. What is the diameter of this circle?", ["16 INCHES", "SIXTEEN INCHES", "16''"]),
        Question("Picasso's paintings can be divided into the three 'color' periods. Name two of them.", ["BLUE, PINK", "BLUE PINK", "BLUE, RED", "BLUE RED", "BLUE, ROSE", "BLUE ROSE", "BLUE, NEGRO", "BLUE NEGRO", "BLUE AND PINK", "BLUE AND RED", "BLUE AND ROSE", "BLUE AND NEGRO", "PINK, BLUE", "PINK BLUE", "PINK, NEGRO", "PINK NEGRO", "RED, BLUE", "RED BLUE", "RED, NEGRO", "RED NEGRO", "ROSE, BLUE", "ROSE BLUE", "ROSE, NEGRO", "ROSE NEGRO", "NEGRO, BLUE", "NEGRO BLUE", "NEGRO, PINK", "NEGRO PINK", "NEGRO, RED", "NEGRO RED","NEGRO, ROSE", "NEGRO ROSE", "NEGRO AND BLUE", "NEGRO AND PINK", "NEGRO AND RED", "NEGRO AND ROSE"]),
        Question("What unit of measurement is defined as 91.44% of one meter?", ["YARD", "A YARD"]),
        Question("How many chambers are there in the human heart?", ["FOUR", "4"]),
        Question("What is the name given to groups of stars which appear to maintain a certain pattern over many years? Draco and Ursa Major are examples.", ["CONSTELLATIONS", "CONSTELLATION"]),
        Question("Change three fifths to a percent.", ["60", "SIXTY", "60%", "SIXTY PERCENT"]),
        Question("Water from hot springs sometimes erupts at the surface of the earth. 'Old Faithful' in Yellowstone National Park is one of these hot springs. What is the name of these springs?", ["GEYSER", "GEYSERS"]),
        Question("Identify the layer of the earth below the crust.", ["MANTLE", "THE MANTLE"]),
        Question("First and last names, please! Name the Academy Award-winning actor, the star of BIG, FORREST GUMP and APOLLO 13.", ["TOM HANKS"]),
        Question("In baseball, what is the slang term for a left-handed pitcher? Part of this term is a cardinal direction.", ["SOUTHPAW", "SOUTH PAW"]),
        Question("Identify the French impressionist artist who painted HAYSTACKS, WATERLILIES, and IMPRESSION: SUNRISE.", ["MONET", "CLAUDE MONET"]),
        Question("According to the headmaster, professors of this subject tend to last for only one year. The teaching position was supposedly cursed by an evil wizard when he visited the school. What is this magical subject taught at Hogwarts School of Witchcraft and Wizardry in J.K. Rowling's Harry Potter series?", ["DEFENSE AGAINST THE DARK ARTS"]),
        Question("First and last please. At age fourteen, this author ran away from home after a difficult childhood living with his alcoholic parents. He traveled with a carnival for a while and held many odd jobs before settling into writing. Name the author of HATCHET.", ["GARY PAULSEN"]),
        Question("In the novel HATCHET, Brian cut through the aluminum body of the submerged plane with his hatchet in order to get what from the aircraft?", ["SURVIVAL PACK", "SURVIVIAL BAG", "SURVIVAL KIT"]),
        Question("Who is the author of DEENIE, TIGER EYES, and the ever-popular FUDGE series?", ["JUDY BLUME", "BLUME"]),
        Question("What is the six letter term for the direct exchange or trade of one good for another, without the use of money?", ["BARTER"]),
        Question("What is the value of six in the number seventy six thousand five hundred ninety-three?", ["SIX THOUSAND", "6,000"]),
        Question("Identify the weapon that was developed during World War Two that was dropped on Hiroshima in an attempt to end the war.", ["ATOMIC BOMB", "NUCLEAR BOMB"]),
        Question("Members of a race of mythical giants which had only a single grotesque eye in the middle of their foreheads were known as what?", ["CYCLOPS"]),
        Question("What phrase from THE ARABIAN NIGHTS does Ali Baba use to gain entrance to the thieves' cave?", ["OPEN SESAME"])
        
    ]
    
    func randomQuestion() -> Question {
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        return questions[randomNumber]
    }
}
