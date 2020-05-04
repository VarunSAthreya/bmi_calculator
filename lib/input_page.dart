import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusableCard.dart';
import 'constants.dart';
import 'results_page.dart';
import 'calculator_brain.dart';

Color shownColor;
enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  Gender selectedGender;
  int height = 170;
  int weight = 50;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI CALCULATOR')),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: (){
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    colour: selectedGender == Gender.male ? kActiveCardColor : kInactiveCardColor,
                    cardChild: CardContents(
                        gender: 'MALE',
                        icon: FontAwesomeIcons.mars
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: (){
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    colour: selectedGender == Gender.female? kActiveCardColor : kInactiveCardColor,
                    cardChild: CardContents(
                      gender: 'FEMALE',
                      icon: FontAwesomeIcons.venus,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
                colour: kActiveCardColor,
              cardChild: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      'HEIGHT',
                      style: kLabelTextStyle
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: kNumberTextStyle,
                      ),
                      Text(
                        'cm',
                        style: kLabelTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbColor: Color(0xFFEB1555),
                      activeTrackColor: Colors.white,
                      overlayColor: Color(0x29EB1555),
                      inactiveTrackColor: Color(0xFF8E8E98),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (double newValue){
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
              Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: (){
                                setState(() {
                                  if(weight>1){
                                    weight--;
                                  }
                                });
                              }
                              ),
                            SizedBox(
                              width: 25.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                            onPressed: (){
                                setState(() {
                                  weight++;
                                });
                            },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(colour: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: (){
                                setState(() {
                                  if(age>1)
                                    age--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 25.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: (){
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  ResultsPage(
                  bmiResult: calc.calculateBMI(),
                  resultText: calc.getResult(),
                  interpretation: calc.getInterpretation(),
                )));
              });
            },
            child: Container(
              color: kBottomContainerColor,
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: kBottomContainerHeight,
              child: Center(
                child: Text(
                  'CALCULATE',
                  style: kLargeButtonTextStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon,@required this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
      ),
      onPressed: onPressed,
      elevation: 0.0,
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5C),
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,

      ),
    );
  }
}



