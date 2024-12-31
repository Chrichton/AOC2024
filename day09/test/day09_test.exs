defmodule Day09Test do
  use ExUnit.Case

  test "read_input" do
    assert Day09.read_input("sample") == "2333133121414131402"
  end

  test "dense_format" do
    assert Day09.from_dense_format("12345") == "0..111....22222"
  end

  test "move_file_blocks" do
    assert Day09.move_file_blocks("0..111....22222") == "022111222......"
  end

  test "checksum" do
    assert Day09.checksum("0099811188827773336446555566..............") == 1928
  end

  test "sample" do
    assert Day09.solve("sample") == 1928
  end

  test "star" do
    # too low
    # assert Day09.solve("star") ==
    assert Day09.checksum(
             "0099999999111192222229933333339444499999999555555589998666669998977777777799799888979999999999799979991010799911791212121212997999691313131313991414141414699969991515699969161616161699691717171717171818181818919191919191919969920202020209699962121212121999222222222222222222599949923232323239499924242449925252525252526262627272727272727949928282894292929292999949993303030303030303030313131313131313131999399323232333333929934343434343434349293535353535992999236937379929383838383838389923939393999929404040404040404099194141414141990999094242424242429943444444989994545454584646999474747474747488994949495050505050989998515199889988525299853535353854549555555559565688575757575858998859595959595999886061616161616161629976363636363646464899656899689669689676767676767676796899589686868686868958969696970958995897171717195899589727272727294873737373737373739947474747474899489948757575993899387676767676769938777777777799389938978787893899379899808080808080808080389981818181288282828282828282828383992884848484848484992898585858585858585859286868686868686868688787878799289928889898989898991899901919191919191919189929292929292929291893939393939919494949494949494899189918959595959969696969696969691979797979789898989898991899189999999999999908990100899081011011011011011011011019908991021021021020103103899089901041041041048990899010510510510510510510510510589910610610610697107107107999108108108108108710910999979997110911111111198799871121121121121121121129987113113991148799871151151151151151151161169117117117987997799118118118118118118118779911911971201201201201201207997799771211211211211211219967996791221221229679967991231231231231231231231236124124124124124799671251251251259967912612612612612691276712812812812812812812812899679912912912912912912957995130130713113113113199513279957995713313313313399413413479947135135135135135135135135135991361361361361361361361361364791371371371371371371371379138138138138138138138138138471391391391399914014014014014014047994799141141141141141141471421421421421421429941431431431431431431431437993144144144144144799314514514514514514514514579937993146146146146146146146799147279927148148148148148148148148992791499150279927151992799279152152911531531531531531531531531537991799154154179917991155155155155155715615615615615615615699179917915715715791581581581581581581581581799079915915915915915907990716016016016016016016016099079916116116116116116116116196999691621621621629869163163163163981641641641641641641641646998699816516516516516516569981661661661661666998616716716716716716716799168169169169169169169817017061711719976997691721721721721721721721721729173173173173173173173173769174174174174174976991751751751751751757699769917617617617717717717717717766178917996618018018018099669918118118118118118118118161826996699618318318318318361841841841841841841841841841851851859956995618618618699187187187187187569956918818894699461899190946994619119219219219219219219299369936919393699369194936993195195195195195195619619619619619619619619699369197197197197197197197197197926198198198199199199199199199199992699269200200200926920120120120120120192699269920220220220220220226992032032032032032032032032699162042042042049916991620520520520520520520520520599169916206206206206206206991699207207207169916208990692092092092099069902102102102102102102106999521121121192122122122129959995992132132132132132142142142142142142149599959992155999216216216216216216216216216217217217217217217599218852192192192199985992202202208599221221221221221221221221221759975997222222222222222222222222599659223223223965922422422496592252252252252259659962262262262265996599227227227227659955992282282282282282282282282285599229523023023023023123123123123123123159923223255995599233233233233233559955995234234234234234234234234599559942352352352352352355923623623623623623623623623694599359237237237237237935238238239239239239993240240240240240240599359932412412412412412412412412415993592422429259922432432432432432432435992244244244244244244244244244599224524524524559915991246246246246246246246246599159912472472475990599024824824824852492492492492492492492492502"
           ) == 1928
  end

  @tag :skip
  test "sample2" do
    assert Day09.solve2("sample") == 34
  end

  @tag :skip
  test "star2" do
    assert Day09.solve2("star") == 884
  end
end
