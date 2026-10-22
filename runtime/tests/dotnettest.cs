// dotnettest.cs — teste de fumaça do .NET (mscoree -> Wine Mono).
//
// O smoke.sh compila este arquivo com o csc.exe da própria bottle e o executa:
// prova que o Mono do runtime (share/wine/mono) foi instalado e roda código
// gerenciado — compilador, CLR, BCL (coleções, LINQ, texto) e P/Invoke.
using System;
using System.Linq;
using System.Runtime.InteropServices;

static class DotNetTest
{
    [DllImport("kernel32.dll")]
    static extern uint GetCurrentProcessId();

    static int Main()
    {
        int sum = Enumerable.Range(1, 100).Where(n => n % 2 == 0).Sum();
        string joined = string.Join(",", new[] { "a", "b", "c" }.Select(s => s.ToUpperInvariant()));
        uint pid = GetCurrentProcessId();

        Console.WriteLine("runtime: .NET " + Environment.Version + (Environment.Is64BitProcess ? " (64-bit)" : " (32-bit)"));
        Console.WriteLine("linq: " + sum + ", texto: " + joined + ", pid: " + pid);
        if (sum != 2550 || joined != "A,B,C" || pid == 0)
        {
            Console.WriteLine("FAIL valores");
            return 1;
        }
        Console.WriteLine("OK");
        return 0;
    }
}
