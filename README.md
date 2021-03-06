# ELTE Fordprog

A beadandóhoz használandó programozási nyelv leírása (Plang, 2019 ősz)
A félév során az alábbi programozási nyelvhez kell fordítóprogramot írni flex és bisonc++ segítségével.

A nyelv egy oktatási célokra készített, egyszerű, imperatív programozási nyelv.

## A nyelv definíciója

### Karakterek

A forrásfájlok a következő ASCII karaktereket tartalmazhatják:
- az angol abc kis és nagybetűi
- számjegyek (0-9)
- ():+-*/%<>=_#
- szóköz, tab, sorvége
- megjegyzések belsejében pedig tetszőleges karakterek állhatnak
- Minden más karakter esetén hibajelzést kell adnia a fordítónak. A nyelv case-sensitive, azaz számít a kis és nagybetűk közötti különbség.

### Kulcsszavak

- A nyelv kulcsszavai a következők: PROGRAM, PROGRAM_VEGE, VALTOZOK:, UTASITASOK:, EGESZ, LOGIKAI, IGAZ, HAMIS, ES, VAGY, NEM, SKIP, HA, AKKOR, KULONBEN, HA_VEGE, CIKLUS, AMIG, CIKLUS_VEGE, KI:, BE:

### Azonosítók

- A változók nevei, illetve a program neve kis- és nagybetűkből, _ jelből és számjegyekből állhatnak, de nem kezdődhetnek számjeggyel, és nem ütközhetnek egyik kulcsszóval sem.

### Típusok

- EGESZ: négy bájtos, előjel nélküli egészként kell megvalósítani; konstansai számjegyekből állnak, és nincs előttük előjel
- LOGIKAI: egy bájton kell ábrázolni, értékei: HAMIS, IGAZ

### Megjegyzések

- A # karakteretől a sor végéig. Megjegyzések a program tetszőleges pontján előfordulhatnak, a fordítást és a keletkező programkódot nem befolyásolják.

## A program felépítése

- A PROGRAM kulcsszóval kezdődik (amit egy tetszőleges azonosító, a program neve követ) és a PROGRAM_VEGE kulcsszóval fejeződik be. (Ezek előtt illetve után csak megjegyzések állhatnak.) A változódeklarációk a program elején találhatóak, és a VALTOZOK: szöveg vezeti be őket. A deklarációs rész opcionális, de ha a VALTOZOK: szöveg megjelenik, akkor legalább egy változót deklarálni kell. A deklarációk után a program utasításai következnek, ezt a részt az UTASITASOK: szöveg vezeti be, és legalább egy utasítást tartalmaznia kell.

### Változódeklarációk

- Minden változót a típusának és nevének megadásával kell deklarálni, több azonos típusú változó esetén mindegyikhez külön ki kell írni a típust.

### Kifejezések

- EGESZ típusú kifejezések: számkonstansok, EGESZ típusú változók és az ezekből a + (összedás), - (kivonás), * (szorzás), / (egészosztás), % (maradékképzés) infix operátorokkal és zárójelekkel a szokásos módon felépített kifejezések.

- LOGIKAI típusú kifejezések: az IGAZ és HAMIS literálok, LOGIKAI típusú változók, két EGESZ típusú kifejezésből az = (egyenlőség), < (kisebb), > (nagyobb), <= (kisebbegyenlő), >= (nagyobbegyenlő) infix operátorokkal előállított, valamint az ezekből ES (konjunkció), VAGY (diszjunkció), = (egyenlőség) infix és a NEM (negáció) prefix operátorral és zárójelekkel a szokásos módon felépített kifejezések.
- Az infix operátorok mind balasszociatívak és a precedenciájuk növevő sorrendben a következő:
  - VAGY
  - ES
  - =
  - < > <= >=
  - \+ -
  - \* / %

### Utasítások

- SKIP utasítás: a változók értékeinek megváltoztatása nélküli továbblépés.
- Értékadás: az := operátorral. Baloldalán egy változó, jobboldalán egy - a változóéval megegyező típusú - kifejezés állhat.
- Olvasás: A BE: utasítás a megadott változóba olvas be egy megfelelő típusú értéket a standard bementeről. (Megvalósítása: meg kell hívni a be eljárást, amit a negyedik beadandó kiírásához mellékelt C fájl tartalmaz. A beolvasott érték EGESZ típus esetén az eax, LOGIKAI típus esetén az al regiszterben lesz.)
- Írás: A KI: utasítás a megadott kifejezés értékét a standard kimenetre írja (és egy sortöréssel fejezi be). (Megvalósítása: meg kell hívni a ki_egesz (vagy a ki_logikai) eljárást, amit a 4. beadandó leírásához mellékelt C fájl tartalmaz. Paraméterként a kiírandó értéket (mindkét esetben 4 bájtot) kell a verembe tenni.)
- Ciklus: CIKLUS AMIG feltétel utasítások CIKLUS_VEGE alakú. A feltétel logikai kifejezés. A ciklus utasításlistája nem lehet üres. A megszokott módon, elöltesztelős ciklusként működik.
- Elágazás: HA feltétel AKKOR utasítások HA_VEGE vagy HA feltétel AKKOR utasítások KULONBEN utasitasok HA_VEGE alakú. A feltétel logikai kifejezés. Az egyes ágak utasításlistái nem lehetnek üresek. A megszokott módon működik.
