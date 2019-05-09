using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GuessTheNumbers
{
    class Program
    {
        static void Main(string[] args)
        {
            //Variables declaration section
            int[] guesses;
            List<int> rndNums;
            String strRndNums;
            String strRightGuesses;
            bool success;

            // "Three randum numbers between 1 and 10 are generated"
            GenerateRandomNumbers(out rndNums, out strRndNums);

            //"User is given 3 chances to guess the number"
            // Intro
            WriteIntro();

            //Getting user guesses
            GetGuesses(rndNums, out guesses, out success, out strRightGuesses);

            //Displaying result
            DisplayFinalResult(success, strRightGuesses, strRndNums);

            //Exit program
            Console.WriteLine("Press any key to exit.");
            Console.ReadKey();
            
        }

        //Displays the rules
        static void WriteIntro()
        {
            Console.WriteLine("********************************************************");
            Console.WriteLine("Hello Player! Welcome to GuessTheNumbers.");
            Console.WriteLine("I've chosen three numbers between 1 and 10.");
            Console.WriteLine("You've got three guesses.");
            Console.WriteLine("If you guess at least one of my numbers, you win.");
            Console.WriteLine("If you guess nothing, you fail.");
            Console.WriteLine("********************************************************");
        }

        //Generates three distinct random numbers between 1 and 10 (inclusive) and populates the rndNums array with it
        //Changes the strRundNums message according to the generated numbers
        static void GenerateRandomNumbers(out List<int> rndNums, out String strRndNums)
        {
            rndNums = new List<int>();
            strRndNums = "";
            Random rnd = new Random();

            // "Three randum numbers between 1 and 10 are generated"
            for (int i = 0; i < 3; i++)
            {
                //Generating a random number between 1 and 10 inclusive
                while (true)
                {
                    int rndNum = rnd.Next(1, 11);
                    if (!rndNums.Contains(rndNum))
                    {
                        rndNums.Add(rndNum);
                        break;
                    }
                }

                strRndNums += "" + rndNums[i] + " ";
            }
        }

        //Get user guesses and compare the guesses with the generated random numbers
        static void GetGuesses(List<int> rndNums, out int[] guesses, out bool success, out String strRightGuesses)
        {
            //User has three guesses
            guesses = new int[3];

            success = false;
            strRightGuesses = "";

            for (int i = 0; i < guesses.Length; i++)
            {
                bool proceed = false;
                while (proceed == false)
                {
                    Console.WriteLine("This is your chance number " + (i + 1) + " type your guess and press ENTER.");
                    Console.WriteLine("PS.: It has to be a number between 1 and 10. No letters allowed, just numbers :)");
                    try
                    {
                        guesses[i] = int.Parse(Console.ReadLine());
                        if (guesses[i] > 0 && guesses[i] < 11)
                        {
                            proceed = true;
                        }
                        else
                        {
                            proceed = false;
                        }
                    }
                    catch
                    {
                        proceed = false;
                    }
                }

                //Comparing the guessed number to the random numbers
                for (int j = 0; j < 3; j++)
                {
                    if (guesses[i] == rndNums[j])
                    {
                        success = true;
                        strRightGuesses += "" + guesses[i] + " ";
                    }
                }

            }
        }

        //Formats and displays the game result
        static void DisplayFinalResult(bool success, String strRightGuesses, String strRndNums)
        {
            //Displaying the final result
            if (success == true)
            {
                //Succeeded
                Console.WriteLine("You won!");
                Console.WriteLine("You've guessed the following numbers right: " + strRightGuesses);
                Console.WriteLine("Those were all the winning numbers: " + strRndNums);
            }
            else
            {
                //Failed
                Console.WriteLine("You failed. ):");
                Console.WriteLine("Those were the winning numbers: " + strRndNums);
            }
        }
    }
}
