# Bootloader

Ponizej prosta instrukcja jak to dziala i jak to uruchomic.

W typowych sytuacjach bootloader byl programem ktory uruchamial sie zaraz po firmwarze zapisanym w pamieci rom komputera.
Firmaware zas byl uruchamiany przez cpu na zasadzie zahardkowadania tej wartosci ( byc moze w postaci modyfikowalnej) na zasadzie skonstrowania odpowiedniego obwodu elektrycznego.

Chodzi o to, ze w ten spsob byla zapisywana pierwsza instrukacja do wykonania przez procesor, pod tym adresem zazwyczaj umieszcza sie firmware. 

Firmware zas szuka po dyskach i urzadzeniach odpowiedniej bitowej sygnatury w poczatkowych bajtach danego nosnika.
Jesli wzorzec sie zgadza przystepuje do kopiowania tego programu do pamieci operacyjnej, w standardach jest ustalone ze to okolo 510-512 bajtow. Nastepnie zas, ustawia adres wykonania intrukcji na znowu standaryzowana wartosc ( tam gdzie zostal wczytany bootloader) i nastepnie bootloader zaczyna byc wykonywany przez procesor.

Rozmiar 512 bajtow jest zwiazany z poziomami bezpiecznestwa procesora tzw. sequrity rings.

W normalnych warunkach bootloader, to program ktory ma dostep i rozumie systemy plikow na dyskach, w jakims standaryzowanym pliku ( o znanej nazwie) przechowuje sie informacje o dostepnych do wczytania systemach operacjnych. 

Nastepnie bootloader bierze kod takiego systemu ( caly lub jego czesc ) i go wczytuje do pamieci operacyjnej, a nastepnie skacze do miejsca jego wykonania. 

W naszym przypadku zamiast tego mamy gre :). Miala byc troche ambitniejsza i artystyczna, ale nie zrobi sie duzo na tych 512 bajtach. Projekt doprowadzilem do momentu kiedy stal sie interaktywny. Zostala dodana prosta funkcjonalnosc przesuwania wskaznika wyboru opcji. Na razie moga panstwo zaobserwowac to na screenach.

Program korzysta z api udostepnionego przez Bios. Tego typu instrukcje wywoluje sie przez specjlany rozkaz procesora zwany przerwaniem. Wtedy w danym rejestrze zapisuje sie czego wlasciwie zadamy, czyli id danej funkcji i jej argumenty. 
Nastenie specjalny rozkaz procesora, wtedy procesor uruchamia kod obslugi przerwania ( znowu standaryzacja i hardkodowana wartosc) a ten kod juz pobiera arugemnty, wie gdzie bios jest, uruchamia jakas jego funkcje, ta funkcja przyjmuje znowu argumenty i w koncu zaczyna rozmawiac z np karta graficzna albo wyswietlaczem.

Podobnie aktywuje sie nasluchiwanie przerwan sprzetowych, oraz rejestracje handlerow ( czyli adresow ) funkcji ktore maja robic jakies ustalone ( juz przez nas programistow) rzeczy jak np czyszczenie ekranu, albo przesuwanie kursora.

Warto wspomniec, ze przedstawiona powyzej informacja dotyczy Legacy Bios, w UEFI firmware ma duzo wieksze uprawnienia, oraz prawdopodobnie nie trzeba sie ograniczac do 512 bajtow.
  

Bede stopniowo dodawal tutaj informacje z racji z tego, ze mam troche problemow na glowie. Niestety zmarl czlonek rodziny wiec prosze Panstwa o wyrozumialosc.


Pozdrawiam
Norbert Marchewka

How to run it:
Potrzebne bedzie qemu i asm.
qemu trzeba sobie samemu pobrac, a asm jest chyba standardowo w dystrybucjach linkusowych.
Pozniej dodam jakas bardziej szczegolowa instrukcje.

