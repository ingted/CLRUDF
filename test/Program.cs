using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace test
{
    class Program
    {
        static void Main(string[] args)
        {
            Object o = 123;
            if (o is int)
            {
                Console.WriteLine("yes!");
            } else
            {
                Console.WriteLine("No!");
            }
            Console.ReadLine();

            returnint(null);
            Console.ReadLine();
        }

        public static int returnint(int? i)
        {
            Console.WriteLine("{0}", i);
            return (int)i;
        }

        public static void testType(Type t)
        {
            //without reflection, not work...
            //dynamic aa = t.Null;
        }
    }
}
