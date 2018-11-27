-- PSC | Power Smart Control | JRF | 2018

--simple 3ph modulator base in the comparison between triangular and 3ph sine signals.
--just for testing NV system in Vivado

--  50Hz sine 
--  10kHz triangular
--  ma max value = 256

    
    library IEEE; 
    use IEEE.STD_LOGIC_1164.ALL; 
    use IEEE.STD_LOGIC_SIGNED.all;
    use IEEE.numeric_std.all; 
    use ieee.std_logic_arith.all;
    
    entity gen_referencias is
        Port ( reset              : in  STD_LOGIC;                          -- 0 1
               clk                : in  STD_LOGIC;                          -- 0 1     
               ma                 : in  std_logic_vector (10 downto 0);     -- 0->255
               T1                 : out std_logic;                          --disparos de transistores
               T2                 : out std_logic;
               T3                 : out std_logic;
               T4                 : out std_logic;
               T5                 : out std_logic;
               T6                 : out std_logic;
               mod_a              : out std_logic_vector (11 downto 0);
               mod_b              : out std_logic_vector (11 downto 0);
               mod_c              : out std_logic_vector (11 downto 0);
               carr_out           : out std_logic_vector (11 downto 0)
               
               ); 
    end gen_referencias;          
                            
    architecture Behavioral of gen_referencias is
        type vector_sin is array (0 to 999) of integer range -356 to 356;       --999 elementos en +-256
        signal sin_vect : vector_sin := (0,2,3,5,6,8,10,11,13,14,16,18,19,21,23,24,26,27,29,31,32,34,35,37,38,40,42,43,45,46,48,50,51,53,54,56,57,59,61,62,64,65,67,68,70,71,73,75,76,78,79,81,82,84,85,87,88,90,91,93,94,96,97,99,100,102,103,105,106,108,109,111,112,113,115,116,118,119,121,122,123,125,126,128,129,130,132,133,135,136,137,139,140,141,143,144,145,147,148,149,151,152,153,154,156,157,158,160,161,162,163,165,166,167,168,169,171,172,173,174,175,177,178,179,180,181,182,183,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,215,216,217,218,219,220,220,221,222,223,224,224,225,226,227,227,228,229,230,230,231,232,232,233,234,234,235,236,236,237,238,238,239,239,240,240,241,242,242,243,243,244,244,245,245,245,246,246,247,247,248,248,248,249,249,250,250,250,251,251,251,252,252,252,252,253,253,253,253,254,254,254,254,254,255,255,255,255,255,255,255,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,255,255,255,255,255,255,255,254,254,254,254,254,253,253,253,253,253,252,252,252,251,251,251,250,250,250,249,249,249,248,248,247,247,247,246,246,245,245,244,244,243,243,242,242,241,241,240,240,239,238,238,237,237,236,235,235,234,233,233,232,231,231,230,229,229,228,227,226,226,225,224,223,223,222,221,220,219,218,218,217,216,215,214,213,212,211,211,210,209,208,207,206,205,204,203,202,201,200,199,198,197,196,195,194,193,192,191,189,188,187,186,185,184,183,182,181,179,178,177,176,175,174,172,171,170,169,168,166,165,164,163,161,160,159,158,156,155,154,153,151,150,149,147,146,145,143,142,141,139,138,137,135,134,133,131,130,128,127,126,124,123,121,120,118,117,116,114,113,111,110,108,107,105,104,103,101,100,98,97,95,94,92,91,89,88,86,85,83,81,80,78,77,75,74,72,71,69,68,66,65,63,61,60,58,57,55,54,52,50,49,47,46,44,42,41,39,38,36,35,33,31,30,28,27,25,23,22,20,19,17,15,14,12,10,9,7,6,4,2,1,-1,-2,-4,-6,-7,-9,-10,-12,-14,-15,-17,-19,-20,-22,-23,-25,-27,-28,-30,-31,-33,-35,-36,-38,-39,-41,-42,-44,-46,-47,-49,-50,-52,-54,-55,-57,-58,-60,-61,-63,-65,-66,-68,-69,-71,-72,-74,-75,-77,-78,-80,-81,-83,-85,-86,-88,-89,-91,-92,-94,-95,-97,-98,-100,-101,-103,-104,-105,-107,-108,-110,-111,-113,-114,-116,-117,-118,-120,-121,-123,-124,-126,-127,-128,-130,-131,-133,-134,-135,-137,-138,-139,-141,-142,-143,-145,-146,-147,-149,-150,-151,-153,-154,-155,-156,-158,-159,-160,-161,-163,-164,-165,-166,-168,-169,-170,-171,-172,-174,-175,-176,-177,-178,-179,-181,-182,-183,-184,-185,-186,-187,-188,-189,-191,-192,-193,-194,-195,-196,-197,-198,-199,-200,-201,-202,-203,-204,-205,-206,-207,-208,-209,-210,-211,-211,-212,-213,-214,-215,-216,-217,-218,-218,-219,-220,-221,-222,-223,-223,-224,-225,-226,-226,-227,-228,-229,-229,-230,-231,-231,-232,-233,-233,-234,-235,-235,-236,-237,-237,-238,-238,-239,-240,-240,-241,-241,-242,-242,-243,-243,-244,-244,-245,-245,-246,-246,-247,-247,-247,-248,-248,-249,-249,-249,-250,-250,-250,-251,-251,-251,-252,-252,-252,-253,-253,-253,-253,-253,-254,-254,-254,-254,-254,-255,-255,-255,-255,-255,-255,-255,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-255,-255,-255,-255,-255,-255,-255,-254,-254,-254,-254,-254,-253,-253,-253,-253,-252,-252,-252,-252,-251,-251,-251,-250,-250,-250,-249,-249,-248,-248,-248,-247,-247,-246,-246,-245,-245,-245,-244,-244,-243,-243,-242,-242,-241,-240,-240,-239,-239,-238,-238,-237,-236,-236,-235,-234,-234,-233,-232,-232,-231,-230,-230,-229,-228,-227,-227,-226,-225,-224,-224,-223,-222,-221,-220,-220,-219,-218,-217,-216,-215,-215,-214,-213,-212,-211,-210,-209,-208,-207,-206,-205,-204,-203,-202,-201,-200,-199,-198,-197,-196,-195,-194,-193,-192,-191,-190,-189,-188,-187,-186,-185,-183,-182,-181,-180,-179,-178,-177,-175,-174,-173,-172,-171,-169,-168,-167,-166,-165,-163,-162,-161,-160,-158,-157,-156,-154,-153,-152,-151,-149,-148,-147,-145,-144,-143,-141,-140,-139,-137,-136,-135,-133,-132,-130,-129,-128,-126,-125,-123,-122,-121,-119,-118,-116,-115,-113,-112,-111,-109,-108,-106,-105,-103,-102,-100,-99,-97,-96,-94,-93,-91,-90,-88,-87,-85,-84,-82,-81,-79,-78,-76,-75,-73,-71,-70,-68,-67,-65,-64,-62,-61,-59,-57,-56,-54,-53,-51,-50,-48,-46,-45,-43,-42,-40,-38,-37,-35,-34,-32,-31,-29,-27,-26,-24,-23,-21,-19,-18,-16,-14,-13,-11,-10,-8,-6,-5,-3,-2, 0);
        
        type vector_tri is array (0 to 999) of integer range -75536 to 75536;   --999 elementos en +-65536
        signal tri_vect : vector_tri := (0,262,525,787,1050,1312,1574,1837,2099,2362,2624,2886,3149,3411,3674,3936,4198,4461,4723,4986,5248,5511,5773,6035,6298,6560,6823,7085,7347,7610,7872,8135,8397,8659,8922,9184,9447,9709,9971,10234,10496,10759,11021,11283,11546,11808,12071,12333,12595,12858,13120,13383,13645,13908,14170,14432,14695,14957,15220,15482,15744,16007,16269,16532,16794,17056,17319,17581,17844,18106,18368,18631,18893,19156,19418,19680,19943,20205,20468,20730,20992,21255,21517,21780,22042,22305,22567,22829,23092,23354,23617,23879,24141,24404,24666,24929,25191,25453,25716,25978,26241,26503,26765,27028,27290,27553,27815,28077,28340,28602,28865,29127,29389,29652,29914,30177,30439,30702,30964,31226,31489,31751,32014,32276,32538,32801,33063,33326,33588,33850,34113,34375,34638,34900,35162,35425,35687,35950,36212,36474,36737,36999,37262,37524,37786,38049,38311,38574,38836,39099,39361,39623,39886,40148,40411,40673,40935,41198,41460,41723,41985,42247,42510,42772,43035,43297,43559,43822,44084,44347,44609,44871,45134,45396,45659,45921,46183,46446,46708,46971,47233,47496,47758,48020,48283,48545,48808,49070,49332,49595,49857,50120,50382,50644,50907,51169,51432,51694,51956,52219,52481,52744,53006,53268,53531,53793,54056,54318,54580,54843,55105,55368,55630,55893,56155,56417,56680,56942,57205,57467,57729,57992,58254,58517,58779,59041,59304,59566,59829,60091,60353,60616,60878,61141,61403,61665,61928,62190,62453,62715,62977,63240,63502,63765,64027,64290,64552,64814,65077,65339,65470,65208,64946,64683,64421,64158,63896,63634,63371,63109,62846,62584,62322,62059,61797,61534,61272,61010,60747,60485,60222,59960,59698,59435,59173,58910,58648,58385,58123,57861,57598,57336,57073,56811,56549,56286,56024,55761,55499,55237,54974,54712,54449,54187,53925,53662,53400,53137,52875,52613,52350,52088,51825,51563,51301,51038,50776,50513,50251,49989,49726,49464,49201,48939,48676,48414,48152,47889,47627,47364,47102,46840,46577,46315,46052,45790,45528,45265,45003,44740,44478,44216,43953,43691,43428,43166,42904,42641,42379,42116,41854,41592,41329,41067,40804,40542,40279,40017,39755,39492,39230,38967,38705,38443,38180,37918,37655,37393,37131,36868,36606,36343,36081,35819,35556,35294,35031,34769,34507,34244,33982,33719,33457,33195,32932,32670,32407,32145,31882,31620,31358,31095,30833,30570,30308,30046,29783,29521,29258,28996,28734,28471,28209,27946,27684,27422,27159,26897,26634,26372,26110,25847,25585,25322,25060,24798,24535,24273,24010,23748,23485,23223,22961,22698,22436,22173,21911,21649,21386,21124,20861,20599,20337,20074,19812,19549,19287,19025,18762,18500,18237,17975,17713,17450,17188,16925,16663,16401,16138,15876,15613,15351,15088,14826,14564,14301,14039,13776,13514,13252,12989,12727,12464,12202,11940,11677,11415,11152,10890,10628,10365,10103,9840,9578,9316,9053,8791,8528,8266,8004,7741,7479,7216,6954,6691,6429,6167,5904,5642,5379,5117,4855,4592,4330,4067,3805,3543,3280,3018,2755,2493,2231,1968,1706,1443,1181,919,656,394,131,-131,-393,-656,-918,-1181,-1443,-1706,-1968,-2230,-2493,-2755,-3018,-3280,-3542,-3805,-4067,-4330,-4592,-4854,-5117,-5379,-5642,-5904,-6166,-6429,-6691,-6954,-7216,-7478,-7741,-8003,-8266,-8528,-8790,-9053,-9315,-9578,-9840,-10103,-10365,-10627,-10890,-11152,-11415,-11677,-11939,-12202,-12464,-12727,-12989,-13251,-13514,-13776,-14039,-14301,-14563,-14826,-15088,-15351,-15613,-15875,-16138,-16400,-16663,-16925,-17187,-17450,-17712,-17975,-18237,-18500,-18762,-19024,-19287,-19549,-19812,-20074,-20336,-20599,-20861,-21124,-21386,-21648,-21911,-22173,-22436,-22698,-22960,-23223,-23485,-23748,-24010,-24272,-24535,-24797,-25060,-25322,-25584,-25847,-26109,-26372,-26634,-26896,-27159,-27421,-27684,-27946,-28209,-28471,-28733,-28996,-29258,-29521,-29783,-30045,-30308,-30570,-30833,-31095,-31357,-31620,-31882,-32145,-32407,-32669,-32932,-33194,-33457,-33719,-33981,-34244,-34506,-34769,-35031,-35293,-35556,-35818,-36081,-36343,-36606,-36868,-37130,-37393,-37655,-37918,-38180,-38442,-38705,-38967,-39230,-39492,-39754,-40017,-40279,-40542,-40804,-41066,-41329,-41591,-41854,-42116,-42378,-42641,-42903,-43166,-43428,-43690,-43953,-44215,-44478,-44740,-45003,-45265,-45527,-45790,-46052,-46315,-46577,-46839,-47102,-47364,-47627,-47889,-48151,-48414,-48676,-48939,-49201,-49463,-49726,-49988,-50251,-50513,-50775,-51038,-51300,-51563,-51825,-52087,-52350,-52612,-52875,-53137,-53400,-53662,-53924,-54187,-54449,-54712,-54974,-55236,-55499,-55761,-56024,-56286,-56548,-56811,-57073,-57336,-57598,-57860,-58123,-58385,-58648,-58910,-59172,-59435,-59697,-59960,-60222,-60484,-60747,-61009,-61272,-61534,-61797,-62059,-62321,-62584,-62846,-63109,-63371,-63633,-63896,-64158,-64421,-64683,-64945,-65208,-65470,-65339,-65077,-64815,-64552,-64290,-64027,-63765,-63503,-63240,-62978,-62715,-62453,-62191,-61928,-61666,-61403,-61141,-60878,-60616,-60354,-60091,-59829,-59566,-59304,-59042,-58779,-58517,-58254,-57992,-57730,-57467,-57205,-56942,-56680,-56418,-56155,-55893,-55630,-55368,-55106,-54843,-54581,-54318,-54056,-53794,-53531,-53269,-53006,-52744,-52481,-52219,-51957,-51694,-51432,-51169,-50907,-50645,-50382,-50120,-49857,-49595,-49333,-49070,-48808,-48545,-48283,-48021,-47758,-47496,-47233,-46971,-46709,-46446,-46184,-45921,-45659,-45397,-45134,-44872,-44609,-44347,-44084,-43822,-43560,-43297,-43035,-42772,-42510,-42248,-41985,-41723,-41460,-41198,-40936,-40673,-40411,-40148,-39886,-39624,-39361,-39099,-38836,-38574,-38312,-38049,-37787,-37524,-37262,-37000,-36737,-36475,-36212,-35950,-35687,-35425,-35163,-34900,-34638,-34375,-34113,-33851,-33588,-33326,-33063,-32801,-32539,-32276,-32014,-31751,-31489,-31227,-30964,-30702,-30439,-30177,-29915,-29652,-29390,-29127,-28865,-28603,-28340,-28078,-27815,-27553,-27291,-27028,-26766,-26503,-26241,-25978,-25716,-25454,-25191,-24929,-24666,-24404,-24142,-23879,-23617,-23354,-23092,-22830,-22567,-22305,-22042,-21780,-21518,-21255,-20993,-20730,-20468,-20206,-19943,-19681,-19418,-19156,-18894,-18631,-18369,-18106,-17844,-17581,-17319,-17057,-16794,-16532,-16269,-16007,-15745,-15482,-15220,-14957,-14695,-14433,-14170,-13908,-13645,-13383,-13121,-12858,-12596,-12333,-12071,-11809,-11546,-11284,-11021,-10759,-10497,-10234,-9972,-9709,-9447,-9184,-8922,-8660,-8397,-8135,-7872,-7610,-7348,-7085,-6823,-6560,-6298,-6036,-5773,-5511,-5248,-4986,-4724,-4461,-4199,-3936,-3674,-3412,-3149,-2887,-2624,-2362,-2100,-1837,-1575,-1312,-1050,-787,-525,-263, 0);     
            
        
        signal sin_A_index      : integer    range 0 to 998;
        signal sin_B_index      : integer    range 0 to 998;
        signal sin_C_index      : integer    range 0 to 998;
        signal ma_aux           : integer    range 0 to 255; 
        signal sin_A_sup        : std_logic_vector (16 downto 0);   
        signal sin_B_sup        : std_logic_vector (16 downto 0);   
        signal sin_C_sup        : std_logic_vector (16 downto 0); 
        
        signal aux        : std_logic_vector (16 downto 0); 
        signal aux_1        : std_logic_vector (11 downto 0); 
        --signal aux_1           : integer    range -2000 to 2000; 
        
        
        signal tri_index     : integer   range 0 to 998;                --posicion actual de los vectores
        signal tri           : integer   range -65535 to 65535; 
                
        signal counter_1     : integer   range 0 to 65535;
        signal counter_2     : integer   range 0 to 65535;
        
        signal enable_100Khz      :   STD_LOGIC;                                  
        signal enable_10Mhz       :   STD_LOGIC;   
        
                                                   
    begin
    
        process (clk, reset)                                
        begin
            if reset='0' then
                enable_100Khz<= '0';        
                enable_10Mhz <= '0';
                counter_1<=0;
                counter_2<=0;
            elsif (clk'event and clk='1') then              
                
                counter_1<=counter_1+1;
                counter_2<=counter_2+1;
                
                if (counter_1>31) then
                    counter_1<=0;
                    enable_10Mhz<='1';
                else
                    enable_10Mhz<='0';
                end if;
                
                if (counter_2>9999) then
                    counter_2<=0;
                    enable_100khz<='1';
                else
                    enable_100khz<='0';
                end if;
                
            end if;
        end process;
    
        process (clk, reset)                                
        begin
            if reset='0' then
                sin_A_index     <= 0;                       
                sin_B_index     <= 332;
                sin_C_index     <= 665;
                sin_A_sup       <= (others => '0');
                sin_B_sup       <= (others => '0');
                sin_C_sup       <= (others => '0'); 
                
                mod_a           <= (others => '0');   
                mod_b           <= (others => '0');   
                mod_c           <= (others => '0'); 
                  
            elsif (clk'event and clk='1') then              
            
            
               if enable_100Khz='1' then    
                    if sin_A_index>997 then
                        sin_A_index<=0;
                    else
                        sin_A_index<=sin_A_index+1;
                    end if;
                    
                    if sin_B_index>997 then
                        sin_B_index<=0;
                    else
                        sin_B_index<=sin_B_index+1;
                    end if;
                    
                    if sin_C_index>997 then
                        sin_C_index<=0;
                    else
                        sin_C_index<=sin_C_index+1;
                    end if;
                    
                    ma_aux      <=conv_integer(ma);
                                                             
                    --modulacion PWM normal
                    sin_A_sup <= std_logic_vector( to_signed( (sin_vect(sin_A_index))*ma_aux, 17));
                    sin_B_sup <= std_logic_vector( to_signed( (sin_vect(sin_B_index))*ma_aux, 17));
                    sin_C_sup <= std_logic_vector( to_signed( (sin_vect(sin_C_index))*ma_aux, 17));
                    
                   -- mod_a <= std_logic_vector( to_signed( (sin_vect(sin_A_index)+2048), 12));
                   -- mod_b <= std_logic_vector( to_signed( (sin_vect(sin_B_index)+2048), 12));
                   -- mod_c <= std_logic_vector( to_signed( (sin_vect(sin_C_index)+2048), 12));
                    
                    mod_a <= (sin_A_sup (16 downto 16) & sin_A_sup (16 downto 16) & sin_A_sup (16 downto 16) & sin_A_sup (16 downto 8)) + "100000000000";   --   "100000000000" = 2048
                    mod_b <= (sin_B_sup (16 downto 16) & sin_B_sup (16 downto 16) & sin_B_sup (16 downto 16) & sin_B_sup (16 downto 8)) + "100000000000";
                    mod_c <= (sin_C_sup (16 downto 16) & sin_C_sup (16 downto 16) & sin_C_sup (16 downto 16) & sin_C_sup (16 downto 8)) + "100000000000";
                    
                    --aux_1 <= (aux (16 downto 16) & aux (16 downto 16) & aux (16 downto 16) & aux (16 downto 8)) + "100000000000";
                    
                end if;                           
            
            end if;
        end process;
        
         process (clk, reset)                                   --aqui se genera la triangular
           begin
               if reset='0' then
                   tri_index<= 0;        
                   tri<=0;
                   
                   aux_1<= (others => '0');
                   aux  <= (others => '0');
                   carr_out  <= (others => '0');
               elsif (clk'event and clk='1') then              --flanco subida
                   if enable_10Mhz='1' then               
                       if tri_index>997 then
                           tri_index<=0;
                       else
                           tri_index<=tri_index+1;
                       end if;
                       
                       tri<=tri_vect(tri_index);
                       
                       aux <= std_logic_vector( to_signed( tri_vect(tri_index), 17));
                       aux_1 <= (aux (16 downto 16) & aux (16 downto 16) & aux (16 downto 16) & aux (16 downto 8)) + "100000000000";
                       --               aux[16] is the number sign   
                       
                       --aux_1 <= conv_integer( aux (11 downto 0));
                       
                       carr_out <= aux_1;
                   end if;
               else
                   tri_index<=tri_index;
                   tri<=tri;
               end if;
           end process;
       
           process (clk, reset)                                  --aqui se generan los disparos de los transistores
           begin
               if reset='0' then
                   T1<='0';
                   T2<='0';
                   T3<='0';
                   T4<='0';
                   T5<='0';
                   T6<='0';
               elsif (clk'event and clk='1') then              --flanco subida
                   if enable_10Mhz='1' then
                       --disparos transistores de arriba
                       if sin_A_sup<tri then
                           T1<= '1';
                           T4<='0';
                       else
                           T1<= '0';
                           T4<='1';
                       end if;        
                       if sin_B_sup<tri then
                           T2<= '1';
                           T5<='0';
                       else
                           T2<= '0';
                           T5<='1';
                       end if;
                       if sin_C_sup<tri then
                           T3<= '1';
                           T6<='0';
                       else
                           T3<= '0';
                           T6<='1';
                       end if;
                    
                   end if;

               end if;
           end process;
      
      
    end Behavioral;     

     

--       -----------------------------
--       |           |       |       |
--   +   |           T1      T2      T3
-- Vcc -----         |-------|-------|------------A
--       -           |       |-------|------------B
--       |           |       |       |------------C
--       |           T4      T5      T6
--       |           |       |       |   
--       -----------------------------

    
--    end Behavioral;     

     

--       -----------------------------
--       |           |       |       |
--   +   |           T1      T2      T3
-- Vcc -----         |-------|-------|------------A
--       -           |       |-------|------------B
--       |           |       |       |------------C
--       |           T4      T5      T6
--       |           |       |       |   
--       -----------------------------

    
    
    

    
--    end Behavioral;     


-------------------------------------------------------


---- PSC | Power Smart Control | JRF | 2018

----simple 3ph modulator base in the comparison between triangular and 3ph sine signals.
----just for testing NV system in Vivado

----  50Hz sine 
----  3kHz triangular
----  ma max value = 256

    
--    library IEEE; 
--    use IEEE.STD_LOGIC_1164.ALL; 
--    use IEEE.STD_LOGIC_SIGNED.all;
--    use IEEE.numeric_std.all; 
--    use ieee.std_logic_arith.all;
    
--    entity gen_referencias is
--        Port ( reset              : in  STD_LOGIC;                          -- 0 1
--               clk                : in  STD_LOGIC;                          -- 0 1     
--               ma_a                 : in  std_logic_vector (9 downto 0);     -- 0->255
--               ma_b                 : in  std_logic_vector (9 downto 0);     -- 0->255
--               ma_c                 : in  std_logic_vector (9 downto 0);     -- 0->255
--               T1                 : out std_logic;                          --disparos de transistores
--               T2                 : out std_logic;
--               T3                 : out std_logic;
--               T4                 : out std_logic;
--               T5                 : out std_logic;
--               T6                 : out std_logic); 
--    end gen_referencias;          
                            
--    architecture Behavioral of gen_referencias is
--        type vector_sin is array (0 to 999) of integer range -356 to 356;       --999 elementos en +-256
--        signal sin_vect : vector_sin := (0,2,3,5,6,8,10,11,13,14,16,18,19,21,23,24,26,27,29,31,32,34,35,37,38,40,42,43,45,46,48,50,51,53,54,56,57,59,61,62,64,65,67,68,70,71,73,75,76,78,79,81,82,84,85,87,88,90,91,93,94,96,97,99,100,102,103,105,106,108,109,111,112,113,115,116,118,119,121,122,123,125,126,128,129,130,132,133,135,136,137,139,140,141,143,144,145,147,148,149,151,152,153,154,156,157,158,160,161,162,163,165,166,167,168,169,171,172,173,174,175,177,178,179,180,181,182,183,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,215,216,217,218,219,220,220,221,222,223,224,224,225,226,227,227,228,229,230,230,231,232,232,233,234,234,235,236,236,237,238,238,239,239,240,240,241,242,242,243,243,244,244,245,245,245,246,246,247,247,248,248,248,249,249,250,250,250,251,251,251,252,252,252,252,253,253,253,253,254,254,254,254,254,255,255,255,255,255,255,255,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,256,255,255,255,255,255,255,255,254,254,254,254,254,253,253,253,253,253,252,252,252,251,251,251,250,250,250,249,249,249,248,248,247,247,247,246,246,245,245,244,244,243,243,242,242,241,241,240,240,239,238,238,237,237,236,235,235,234,233,233,232,231,231,230,229,229,228,227,226,226,225,224,223,223,222,221,220,219,218,218,217,216,215,214,213,212,211,211,210,209,208,207,206,205,204,203,202,201,200,199,198,197,196,195,194,193,192,191,189,188,187,186,185,184,183,182,181,179,178,177,176,175,174,172,171,170,169,168,166,165,164,163,161,160,159,158,156,155,154,153,151,150,149,147,146,145,143,142,141,139,138,137,135,134,133,131,130,128,127,126,124,123,121,120,118,117,116,114,113,111,110,108,107,105,104,103,101,100,98,97,95,94,92,91,89,88,86,85,83,81,80,78,77,75,74,72,71,69,68,66,65,63,61,60,58,57,55,54,52,50,49,47,46,44,42,41,39,38,36,35,33,31,30,28,27,25,23,22,20,19,17,15,14,12,10,9,7,6,4,2,1,-1,-2,-4,-6,-7,-9,-10,-12,-14,-15,-17,-19,-20,-22,-23,-25,-27,-28,-30,-31,-33,-35,-36,-38,-39,-41,-42,-44,-46,-47,-49,-50,-52,-54,-55,-57,-58,-60,-61,-63,-65,-66,-68,-69,-71,-72,-74,-75,-77,-78,-80,-81,-83,-85,-86,-88,-89,-91,-92,-94,-95,-97,-98,-100,-101,-103,-104,-105,-107,-108,-110,-111,-113,-114,-116,-117,-118,-120,-121,-123,-124,-126,-127,-128,-130,-131,-133,-134,-135,-137,-138,-139,-141,-142,-143,-145,-146,-147,-149,-150,-151,-153,-154,-155,-156,-158,-159,-160,-161,-163,-164,-165,-166,-168,-169,-170,-171,-172,-174,-175,-176,-177,-178,-179,-181,-182,-183,-184,-185,-186,-187,-188,-189,-191,-192,-193,-194,-195,-196,-197,-198,-199,-200,-201,-202,-203,-204,-205,-206,-207,-208,-209,-210,-211,-211,-212,-213,-214,-215,-216,-217,-218,-218,-219,-220,-221,-222,-223,-223,-224,-225,-226,-226,-227,-228,-229,-229,-230,-231,-231,-232,-233,-233,-234,-235,-235,-236,-237,-237,-238,-238,-239,-240,-240,-241,-241,-242,-242,-243,-243,-244,-244,-245,-245,-246,-246,-247,-247,-247,-248,-248,-249,-249,-249,-250,-250,-250,-251,-251,-251,-252,-252,-252,-253,-253,-253,-253,-253,-254,-254,-254,-254,-254,-255,-255,-255,-255,-255,-255,-255,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-256,-255,-255,-255,-255,-255,-255,-255,-254,-254,-254,-254,-254,-253,-253,-253,-253,-252,-252,-252,-252,-251,-251,-251,-250,-250,-250,-249,-249,-248,-248,-248,-247,-247,-246,-246,-245,-245,-245,-244,-244,-243,-243,-242,-242,-241,-240,-240,-239,-239,-238,-238,-237,-236,-236,-235,-234,-234,-233,-232,-232,-231,-230,-230,-229,-228,-227,-227,-226,-225,-224,-224,-223,-222,-221,-220,-220,-219,-218,-217,-216,-215,-215,-214,-213,-212,-211,-210,-209,-208,-207,-206,-205,-204,-203,-202,-201,-200,-199,-198,-197,-196,-195,-194,-193,-192,-191,-190,-189,-188,-187,-186,-185,-183,-182,-181,-180,-179,-178,-177,-175,-174,-173,-172,-171,-169,-168,-167,-166,-165,-163,-162,-161,-160,-158,-157,-156,-154,-153,-152,-151,-149,-148,-147,-145,-144,-143,-141,-140,-139,-137,-136,-135,-133,-132,-130,-129,-128,-126,-125,-123,-122,-121,-119,-118,-116,-115,-113,-112,-111,-109,-108,-106,-105,-103,-102,-100,-99,-97,-96,-94,-93,-91,-90,-88,-87,-85,-84,-82,-81,-79,-78,-76,-75,-73,-71,-70,-68,-67,-65,-64,-62,-61,-59,-57,-56,-54,-53,-51,-50,-48,-46,-45,-43,-42,-40,-38,-37,-35,-34,-32,-31,-29,-27,-26,-24,-23,-21,-19,-18,-16,-14,-13,-11,-10,-8,-6,-5,-3,-2, 0);
        
--        type vector_tri is array (0 to 999) of integer range -75536 to 75536;   --999 elementos en +-65536
--        signal tri_vect : vector_tri := (0,262,525,787,1050,1312,1574,1837,2099,2362,2624,2886,3149,3411,3674,3936,4198,4461,4723,4986,5248,5511,5773,6035,6298,6560,6823,7085,7347,7610,7872,8135,8397,8659,8922,9184,9447,9709,9971,10234,10496,10759,11021,11283,11546,11808,12071,12333,12595,12858,13120,13383,13645,13908,14170,14432,14695,14957,15220,15482,15744,16007,16269,16532,16794,17056,17319,17581,17844,18106,18368,18631,18893,19156,19418,19680,19943,20205,20468,20730,20992,21255,21517,21780,22042,22305,22567,22829,23092,23354,23617,23879,24141,24404,24666,24929,25191,25453,25716,25978,26241,26503,26765,27028,27290,27553,27815,28077,28340,28602,28865,29127,29389,29652,29914,30177,30439,30702,30964,31226,31489,31751,32014,32276,32538,32801,33063,33326,33588,33850,34113,34375,34638,34900,35162,35425,35687,35950,36212,36474,36737,36999,37262,37524,37786,38049,38311,38574,38836,39099,39361,39623,39886,40148,40411,40673,40935,41198,41460,41723,41985,42247,42510,42772,43035,43297,43559,43822,44084,44347,44609,44871,45134,45396,45659,45921,46183,46446,46708,46971,47233,47496,47758,48020,48283,48545,48808,49070,49332,49595,49857,50120,50382,50644,50907,51169,51432,51694,51956,52219,52481,52744,53006,53268,53531,53793,54056,54318,54580,54843,55105,55368,55630,55893,56155,56417,56680,56942,57205,57467,57729,57992,58254,58517,58779,59041,59304,59566,59829,60091,60353,60616,60878,61141,61403,61665,61928,62190,62453,62715,62977,63240,63502,63765,64027,64290,64552,64814,65077,65339,65470,65208,64946,64683,64421,64158,63896,63634,63371,63109,62846,62584,62322,62059,61797,61534,61272,61010,60747,60485,60222,59960,59698,59435,59173,58910,58648,58385,58123,57861,57598,57336,57073,56811,56549,56286,56024,55761,55499,55237,54974,54712,54449,54187,53925,53662,53400,53137,52875,52613,52350,52088,51825,51563,51301,51038,50776,50513,50251,49989,49726,49464,49201,48939,48676,48414,48152,47889,47627,47364,47102,46840,46577,46315,46052,45790,45528,45265,45003,44740,44478,44216,43953,43691,43428,43166,42904,42641,42379,42116,41854,41592,41329,41067,40804,40542,40279,40017,39755,39492,39230,38967,38705,38443,38180,37918,37655,37393,37131,36868,36606,36343,36081,35819,35556,35294,35031,34769,34507,34244,33982,33719,33457,33195,32932,32670,32407,32145,31882,31620,31358,31095,30833,30570,30308,30046,29783,29521,29258,28996,28734,28471,28209,27946,27684,27422,27159,26897,26634,26372,26110,25847,25585,25322,25060,24798,24535,24273,24010,23748,23485,23223,22961,22698,22436,22173,21911,21649,21386,21124,20861,20599,20337,20074,19812,19549,19287,19025,18762,18500,18237,17975,17713,17450,17188,16925,16663,16401,16138,15876,15613,15351,15088,14826,14564,14301,14039,13776,13514,13252,12989,12727,12464,12202,11940,11677,11415,11152,10890,10628,10365,10103,9840,9578,9316,9053,8791,8528,8266,8004,7741,7479,7216,6954,6691,6429,6167,5904,5642,5379,5117,4855,4592,4330,4067,3805,3543,3280,3018,2755,2493,2231,1968,1706,1443,1181,919,656,394,131,-131,-393,-656,-918,-1181,-1443,-1706,-1968,-2230,-2493,-2755,-3018,-3280,-3542,-3805,-4067,-4330,-4592,-4854,-5117,-5379,-5642,-5904,-6166,-6429,-6691,-6954,-7216,-7478,-7741,-8003,-8266,-8528,-8790,-9053,-9315,-9578,-9840,-10103,-10365,-10627,-10890,-11152,-11415,-11677,-11939,-12202,-12464,-12727,-12989,-13251,-13514,-13776,-14039,-14301,-14563,-14826,-15088,-15351,-15613,-15875,-16138,-16400,-16663,-16925,-17187,-17450,-17712,-17975,-18237,-18500,-18762,-19024,-19287,-19549,-19812,-20074,-20336,-20599,-20861,-21124,-21386,-21648,-21911,-22173,-22436,-22698,-22960,-23223,-23485,-23748,-24010,-24272,-24535,-24797,-25060,-25322,-25584,-25847,-26109,-26372,-26634,-26896,-27159,-27421,-27684,-27946,-28209,-28471,-28733,-28996,-29258,-29521,-29783,-30045,-30308,-30570,-30833,-31095,-31357,-31620,-31882,-32145,-32407,-32669,-32932,-33194,-33457,-33719,-33981,-34244,-34506,-34769,-35031,-35293,-35556,-35818,-36081,-36343,-36606,-36868,-37130,-37393,-37655,-37918,-38180,-38442,-38705,-38967,-39230,-39492,-39754,-40017,-40279,-40542,-40804,-41066,-41329,-41591,-41854,-42116,-42378,-42641,-42903,-43166,-43428,-43690,-43953,-44215,-44478,-44740,-45003,-45265,-45527,-45790,-46052,-46315,-46577,-46839,-47102,-47364,-47627,-47889,-48151,-48414,-48676,-48939,-49201,-49463,-49726,-49988,-50251,-50513,-50775,-51038,-51300,-51563,-51825,-52087,-52350,-52612,-52875,-53137,-53400,-53662,-53924,-54187,-54449,-54712,-54974,-55236,-55499,-55761,-56024,-56286,-56548,-56811,-57073,-57336,-57598,-57860,-58123,-58385,-58648,-58910,-59172,-59435,-59697,-59960,-60222,-60484,-60747,-61009,-61272,-61534,-61797,-62059,-62321,-62584,-62846,-63109,-63371,-63633,-63896,-64158,-64421,-64683,-64945,-65208,-65470,-65339,-65077,-64815,-64552,-64290,-64027,-63765,-63503,-63240,-62978,-62715,-62453,-62191,-61928,-61666,-61403,-61141,-60878,-60616,-60354,-60091,-59829,-59566,-59304,-59042,-58779,-58517,-58254,-57992,-57730,-57467,-57205,-56942,-56680,-56418,-56155,-55893,-55630,-55368,-55106,-54843,-54581,-54318,-54056,-53794,-53531,-53269,-53006,-52744,-52481,-52219,-51957,-51694,-51432,-51169,-50907,-50645,-50382,-50120,-49857,-49595,-49333,-49070,-48808,-48545,-48283,-48021,-47758,-47496,-47233,-46971,-46709,-46446,-46184,-45921,-45659,-45397,-45134,-44872,-44609,-44347,-44084,-43822,-43560,-43297,-43035,-42772,-42510,-42248,-41985,-41723,-41460,-41198,-40936,-40673,-40411,-40148,-39886,-39624,-39361,-39099,-38836,-38574,-38312,-38049,-37787,-37524,-37262,-37000,-36737,-36475,-36212,-35950,-35687,-35425,-35163,-34900,-34638,-34375,-34113,-33851,-33588,-33326,-33063,-32801,-32539,-32276,-32014,-31751,-31489,-31227,-30964,-30702,-30439,-30177,-29915,-29652,-29390,-29127,-28865,-28603,-28340,-28078,-27815,-27553,-27291,-27028,-26766,-26503,-26241,-25978,-25716,-25454,-25191,-24929,-24666,-24404,-24142,-23879,-23617,-23354,-23092,-22830,-22567,-22305,-22042,-21780,-21518,-21255,-20993,-20730,-20468,-20206,-19943,-19681,-19418,-19156,-18894,-18631,-18369,-18106,-17844,-17581,-17319,-17057,-16794,-16532,-16269,-16007,-15745,-15482,-15220,-14957,-14695,-14433,-14170,-13908,-13645,-13383,-13121,-12858,-12596,-12333,-12071,-11809,-11546,-11284,-11021,-10759,-10497,-10234,-9972,-9709,-9447,-9184,-8922,-8660,-8397,-8135,-7872,-7610,-7348,-7085,-6823,-6560,-6298,-6036,-5773,-5511,-5248,-4986,-4724,-4461,-4199,-3936,-3674,-3412,-3149,-2887,-2624,-2362,-2100,-1837,-1575,-1312,-1050,-787,-525,-263, 0);     
            
        
--        signal sin_A_index      : integer    range 0 to 998;
--        signal sin_B_index      : integer    range 0 to 998;
--        signal sin_C_index      : integer    range 0 to 998;
--        signal ma_aux, mb_aux, mc_aux           : integer    range 0 to 255; 
--        signal sin_A_sup        : std_logic_vector (19 downto 0);   
--        signal sin_B_sup        : std_logic_vector (19 downto 0);   
--        signal sin_C_sup        : std_logic_vector (19 downto 0);   
--        signal ckt              : std_logic_vector (9 downto 0) := "0011111111"; 
        
        
--        signal tri_index     : integer   range 0 to 998;                --posicion actual de los vectores
--        signal tri           : integer   range -65535 to 65535; 
                
--        signal counter_1     : integer   range 0 to 65535;
--        signal counter_2     : integer   range 0 to 999965535;
        
--        signal enable_100Khz      :   STD_LOGIC;                                  
--        signal enable_10Mhz       :   STD_LOGIC;   
        
                                                   
--    begin
    
--        --re escalate modulators
--        sin_A_sup <= ma_a*ckt;
--        sin_B_sup <= ma_b*ckt;
--        sin_C_sup <= ma_c*ckt;
                    
            
--         process (clk, reset)                                   --aqui se genera la triangular
--           begin
--               if reset='0' then
--                   tri_index<= 0;        
--                   tri<=0;
--               elsif (clk'event and clk='1') then              --flanco subida
--                   if enable_10Mhz='1' then               
--                       if tri_index>997 then
--                           tri_index<=0;
--                       else
--                           tri_index<=tri_index+1;
--                       end if;
                       
--                       tri<=tri_vect(tri_index);
--                   end if;
--               else
--                   tri_index<=tri_index;
--                   tri<=tri;
--               end if;
--           end process;
       
--           process (clk, reset)                                  --aqui se generan los disparos de los transistores
--           begin
--               if reset='0' then
--                   T1<='0';
--                   T2<='0';
--                   T3<='0';
--                   T4<='0';
--                   T5<='0';
--                   T6<='0';
--               elsif (clk'event and clk='1') then              --flanco subida
--                   if enable_10Mhz='1' then
--                       --disparos transistores de arriba
--                       if sin_A_sup<tri then
--                           T1<= '1';
--                           T4<='0';
--                       else
--                           T1<= '0';
--                           T4<='1';
--                       end if;        
--                       if sin_B_sup<tri then
--                           T2<= '1';
--                           T5<='0';
--                       else
--                           T2<= '0';
--                           T5<='1';
--                       end if;
--                       if sin_C_sup<tri then
--                           T3<= '1';
--                           T6<='0';
--                       else
--                           T3<= '0';
--                           T6<='1';
--                       end if;
                    
--                   end if;

--               end if;
--           end process;
      
      
--    end Behavioral;     

     

--       -----------------------------
--       |           |       |       |
--   +   |           T1      T2      T3
-- Vcc -----         |-------|-------|------------A
--       -           |       |-------|------------B
--       |           |       |       |------------C
--       |           T4      T5      T6
--       |           |       |       |   
--       -----------------------------

    
    