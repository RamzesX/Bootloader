# Bootloader

Przede wszystkim Bootloader to program napisany najczęściej w asemblerze ( z racji na ograniczona ilość pamięci), który jest taką trampoliną służąca do załadownia systemu operacyjnego do pamięci. Poniższy artykuł opisuje go oraz jego powiązania z innymi komponentami systemu operacyjnego. 

W dalszej części jest opis jak zmieniłem jego domyślne zachowanie, aby stworzyć prostą grę.

W typowych sytuacjach bootloader był programem który był uruchamiany przez firmware taki jak bios. Lokalizacja biosu to pamięc rom, czyli taka, ktora nie znika z pamięci komputera a cpu ma do niej zawsze dostep.

Firmware był uruchamiany przez cpu na zasadzie zahardkodowania takiego zachowania na zasadzie skonstruowania odpowiedniego obwodu elektrycznego w obrebie cpu.

Chodzi o to, ze w ten sposób była zapisywana pierwsza instrukcja do wykonania przez procesor, a ta wartośc to był numer komorki pamieci gdzie ten firmware sie zaczynał.

Firmware zaś szukal po dyskach i urządzeniach odpowiedniej bitowej sygnatury w początkowych bajtach danego nośnika.
Jeśli wzorzec się zgadzal przystępował do kopiowania tego programu do pamięci operacyjnej, w standardach jest ustalone ze to około 510-512 bajtów. Następnie zaś, ustawiał adres wykonania instrukcji na znowu standaryzowanej wartości ( tam gdzie został wczytany bootloader) i następnie bootloader zaczyna być wykonywany przez procesor.

Rozmiar 512 bajtów jest związany z trybami adresowymi. Chodzi o to, że z jakiegoś powodu( niejasnego dla nikogo oprócz Intela) procesor musi emulować po kolei działanie starszych procesorów. I w tym trybie w którym ma działac bootloader jest to 512 bajtów. 

W normalnych warunkach bootloader, to program który ma dostęp i rozumie systemy plików na dyskach. Więc w jakimś standaryzowanym pliku ( o znanej nazwie) przechowuje się informacje o dostępnych do wczytania systemach operacyjnych. 

Następnie bootloader bierze kod takiego systemu ( cały lub jego cześć ) i go wczytuje do pamięci operacyjnej, a następnie skacze do miejca go wczytał a potem ten os zaczyna się wykonywać.

W naszym przypadku zamiast tego mamy grę :). Miała być trochę ambitniejsza i artystyczna, ale nie zrobi się dużo na tych 512 bajtach. Projekt doprowadziłem do momentu kiedy stal się interaktywny. Została dodana prosta funkcjonalność przesuwania wskaźnika wyboru opcji. Na razie mogą państwo zaobserwować to na screenach.

Program korzysta z api udostępnionego przez Bios. Tego typu instrukcje wywołuje się przez specjalny rozkaz procesora zwany przerwaniem. Wtedy w danym rejestrze zapisuje się czego właściwie zadamy, czyli id danej funkcji i jej argumenty. 
Następnie wykonujemy specjalny rozkaz procesora, wtedy procesor uruchamia kod obsługi przerwania (zapisany gdzies w obszarze biosu) a ten kod już pobiera argumenty, wie gdzie jest docelowa funkcja. 

Podobnie aktywuje się nasłuchiwanie przerwań sprzętowych, oraz rejestracje handlerów ( czyli adresów ) funkcji które maja robić jakieś ustalone ( już przez nas programistów) rzeczy jak np czyszczenie ekranu, albo przesuwanie kursora w odpowiedzi na zewnetrzne zdarzenia.

Warto wspomnieć, ze przedstawiona powyżej informacja dotyczy Legacy Bios, w UEFI firmware ma dużo większe uprawnienia, oraz prawdopodobnie nie trzeba się ograniczać do 512 bajtów.

Cały ten proces dzieje się na jednym rdzeniu, zazwyczaj os uruchamia sam pozostałe.
Komercyjne programy jak Grub i LILO, to takie które udają system operacyjny, czyli to ich Bootloader wczytuje.
  


How to run it:
Potrzebne będzie qemu i nasm.

nasm:
sudo apt-get install nasm
                                                                                       





quemu: 
apt-get install qemu

Potem trzeba zrobic make-a takiego jak w plikach projektu.

