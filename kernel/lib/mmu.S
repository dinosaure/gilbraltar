
/*
 * This file was automatically generated using arm64-pgtable-tool.
 * See: https://github.com/ashwio/arm64-pgtable-tool
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * This code programs the following translation table structure:
 *
 *         level 1 table @ 0x2f000000
 *         [#   0]---------------------------\
 *                 level 2 table @ 0x2f001000
 *                 [#   0] 0x000000000000-0x0000001fffff, Code, CODE
 *                 [#   1] 0x000000200000-0x0000003fffff, Code, CODE
 *                 [#   2] 0x000000400000-0x0000005fffff, Code, CODE
 *                 [#   3] 0x000000600000-0x0000007fffff, Code, CODE
 *                 [#   4] 0x000000800000-0x0000009fffff, Code, CODE
 *                 [#   5] 0x000000a00000-0x000000bfffff, Code, CODE
 *                 [#   6] 0x000000c00000-0x000000dfffff, Code, CODE
 *                 [#   7] 0x000000e00000-0x000000ffffff, Code, CODE
 *                 [#   8] 0x000001000000-0x0000011fffff, RW_Data, RAM
 *                 [#   9] 0x000001200000-0x0000013fffff, RW_Data, RAM
 *                 [#  10] 0x000001400000-0x0000015fffff, RW_Data, RAM
 *                 [#  11] 0x000001600000-0x0000017fffff, RW_Data, RAM
 *                 [#  12] 0x000001800000-0x0000019fffff, RW_Data, RAM
 *                 [#  13] 0x000001a00000-0x000001bfffff, RW_Data, RAM
 *                 [#  14] 0x000001c00000-0x000001dfffff, RW_Data, RAM
 *                 [#  15] 0x000001e00000-0x000001ffffff, RW_Data, RAM
 *                 [#  16] 0x000002000000-0x0000021fffff, RW_Data, RAM
 *                 [#  17] 0x000002200000-0x0000023fffff, RW_Data, RAM
 *                 [#  18] 0x000002400000-0x0000025fffff, RW_Data, RAM
 *                 [#  19] 0x000002600000-0x0000027fffff, RW_Data, RAM
 *                 [#  20] 0x000002800000-0x0000029fffff, RW_Data, RAM
 *                 [#  21] 0x000002a00000-0x000002bfffff, RW_Data, RAM
 *                 [#  22] 0x000002c00000-0x000002dfffff, RW_Data, RAM
 *                 [#  23] 0x000002e00000-0x000002ffffff, RW_Data, RAM
 *                 [#  24] 0x000003000000-0x0000031fffff, RW_Data, RAM
 *                 [#  25] 0x000003200000-0x0000033fffff, RW_Data, RAM
 *                 [#  26] 0x000003400000-0x0000035fffff, RW_Data, RAM
 *                 [#  27] 0x000003600000-0x0000037fffff, RW_Data, RAM
 *                 [#  28] 0x000003800000-0x0000039fffff, RW_Data, RAM
 *                 [#  29] 0x000003a00000-0x000003bfffff, RW_Data, RAM
 *                 [#  30] 0x000003c00000-0x000003dfffff, RW_Data, RAM
 *                 [#  31] 0x000003e00000-0x000003ffffff, RW_Data, RAM
 *                 [#  32] 0x000004000000-0x0000041fffff, RW_Data, RAM
 *                 [#  33] 0x000004200000-0x0000043fffff, RW_Data, RAM
 *                 [#  34] 0x000004400000-0x0000045fffff, RW_Data, RAM
 *                 [#  35] 0x000004600000-0x0000047fffff, RW_Data, RAM
 *                 [#  36] 0x000004800000-0x0000049fffff, RW_Data, RAM
 *                 [#  37] 0x000004a00000-0x000004bfffff, RW_Data, RAM
 *                 [#  38] 0x000004c00000-0x000004dfffff, RW_Data, RAM
 *                 [#  39] 0x000004e00000-0x000004ffffff, RW_Data, RAM
 *                 [#  40] 0x000005000000-0x0000051fffff, RW_Data, RAM
 *                 [#  41] 0x000005200000-0x0000053fffff, RW_Data, RAM
 *                 [#  42] 0x000005400000-0x0000055fffff, RW_Data, RAM
 *                 [#  43] 0x000005600000-0x0000057fffff, RW_Data, RAM
 *                 [#  44] 0x000005800000-0x0000059fffff, RW_Data, RAM
 *                 [#  45] 0x000005a00000-0x000005bfffff, RW_Data, RAM
 *                 [#  46] 0x000005c00000-0x000005dfffff, RW_Data, RAM
 *                 [#  47] 0x000005e00000-0x000005ffffff, RW_Data, RAM
 *                 [#  48] 0x000006000000-0x0000061fffff, RW_Data, RAM
 *                 [#  49] 0x000006200000-0x0000063fffff, RW_Data, RAM
 *                 [#  50] 0x000006400000-0x0000065fffff, RW_Data, RAM
 *                 [#  51] 0x000006600000-0x0000067fffff, RW_Data, RAM
 *                 [#  52] 0x000006800000-0x0000069fffff, RW_Data, RAM
 *                 [#  53] 0x000006a00000-0x000006bfffff, RW_Data, RAM
 *                 [#  54] 0x000006c00000-0x000006dfffff, RW_Data, RAM
 *                 [#  55] 0x000006e00000-0x000006ffffff, RW_Data, RAM
 *                 [#  56] 0x000007000000-0x0000071fffff, RW_Data, RAM
 *                 [#  57] 0x000007200000-0x0000073fffff, RW_Data, RAM
 *                 [#  58] 0x000007400000-0x0000075fffff, RW_Data, RAM
 *                 [#  59] 0x000007600000-0x0000077fffff, RW_Data, RAM
 *                 [#  60] 0x000007800000-0x0000079fffff, RW_Data, RAM
 *                 [#  61] 0x000007a00000-0x000007bfffff, RW_Data, RAM
 *                 [#  62] 0x000007c00000-0x000007dfffff, RW_Data, RAM
 *                 [#  63] 0x000007e00000-0x000007ffffff, RW_Data, RAM
 *                 [#  64] 0x000008000000-0x0000081fffff, RW_Data, RAM
 *                 [#  65] 0x000008200000-0x0000083fffff, RW_Data, RAM
 *                 [#  66] 0x000008400000-0x0000085fffff, RW_Data, RAM
 *                 [#  67] 0x000008600000-0x0000087fffff, RW_Data, RAM
 *                 [#  68] 0x000008800000-0x0000089fffff, RW_Data, RAM
 *                 [#  69] 0x000008a00000-0x000008bfffff, RW_Data, RAM
 *                 [#  70] 0x000008c00000-0x000008dfffff, RW_Data, RAM
 *                 [#  71] 0x000008e00000-0x000008ffffff, RW_Data, RAM
 *                 [#  72] 0x000009000000-0x0000091fffff, RW_Data, RAM
 *                 [#  73] 0x000009200000-0x0000093fffff, RW_Data, RAM
 *                 [#  74] 0x000009400000-0x0000095fffff, RW_Data, RAM
 *                 [#  75] 0x000009600000-0x0000097fffff, RW_Data, RAM
 *                 [#  76] 0x000009800000-0x0000099fffff, RW_Data, RAM
 *                 [#  77] 0x000009a00000-0x000009bfffff, RW_Data, RAM
 *                 [#  78] 0x000009c00000-0x000009dfffff, RW_Data, RAM
 *                 [#  79] 0x000009e00000-0x000009ffffff, RW_Data, RAM
 *                 [#  80] 0x00000a000000-0x00000a1fffff, RW_Data, RAM
 *                 [#  81] 0x00000a200000-0x00000a3fffff, RW_Data, RAM
 *                 [#  82] 0x00000a400000-0x00000a5fffff, RW_Data, RAM
 *                 [#  83] 0x00000a600000-0x00000a7fffff, RW_Data, RAM
 *                 [#  84] 0x00000a800000-0x00000a9fffff, RW_Data, RAM
 *                 [#  85] 0x00000aa00000-0x00000abfffff, RW_Data, RAM
 *                 [#  86] 0x00000ac00000-0x00000adfffff, RW_Data, RAM
 *                 [#  87] 0x00000ae00000-0x00000affffff, RW_Data, RAM
 *                 [#  88] 0x00000b000000-0x00000b1fffff, RW_Data, RAM
 *                 [#  89] 0x00000b200000-0x00000b3fffff, RW_Data, RAM
 *                 [#  90] 0x00000b400000-0x00000b5fffff, RW_Data, RAM
 *                 [#  91] 0x00000b600000-0x00000b7fffff, RW_Data, RAM
 *                 [#  92] 0x00000b800000-0x00000b9fffff, RW_Data, RAM
 *                 [#  93] 0x00000ba00000-0x00000bbfffff, RW_Data, RAM
 *                 [#  94] 0x00000bc00000-0x00000bdfffff, RW_Data, RAM
 *                 [#  95] 0x00000be00000-0x00000bffffff, RW_Data, RAM
 *                 [#  96] 0x00000c000000-0x00000c1fffff, RW_Data, RAM
 *                 [#  97] 0x00000c200000-0x00000c3fffff, RW_Data, RAM
 *                 [#  98] 0x00000c400000-0x00000c5fffff, RW_Data, RAM
 *                 [#  99] 0x00000c600000-0x00000c7fffff, RW_Data, RAM
 *                 [# 100] 0x00000c800000-0x00000c9fffff, RW_Data, RAM
 *                 [# 101] 0x00000ca00000-0x00000cbfffff, RW_Data, RAM
 *                 [# 102] 0x00000cc00000-0x00000cdfffff, RW_Data, RAM
 *                 [# 103] 0x00000ce00000-0x00000cffffff, RW_Data, RAM
 *                 [# 104] 0x00000d000000-0x00000d1fffff, RW_Data, RAM
 *                 [# 105] 0x00000d200000-0x00000d3fffff, RW_Data, RAM
 *                 [# 106] 0x00000d400000-0x00000d5fffff, RW_Data, RAM
 *                 [# 107] 0x00000d600000-0x00000d7fffff, RW_Data, RAM
 *                 [# 108] 0x00000d800000-0x00000d9fffff, RW_Data, RAM
 *                 [# 109] 0x00000da00000-0x00000dbfffff, RW_Data, RAM
 *                 [# 110] 0x00000dc00000-0x00000ddfffff, RW_Data, RAM
 *                 [# 111] 0x00000de00000-0x00000dffffff, RW_Data, RAM
 *                 [# 112] 0x00000e000000-0x00000e1fffff, RW_Data, RAM
 *                 [# 113] 0x00000e200000-0x00000e3fffff, RW_Data, RAM
 *                 [# 114] 0x00000e400000-0x00000e5fffff, RW_Data, RAM
 *                 [# 115] 0x00000e600000-0x00000e7fffff, RW_Data, RAM
 *                 [# 116] 0x00000e800000-0x00000e9fffff, RW_Data, RAM
 *                 [# 117] 0x00000ea00000-0x00000ebfffff, RW_Data, RAM
 *                 [# 118] 0x00000ec00000-0x00000edfffff, RW_Data, RAM
 *                 [# 119] 0x00000ee00000-0x00000effffff, RW_Data, RAM
 *                 [# 120] 0x00000f000000-0x00000f1fffff, RW_Data, RAM
 *                 [# 121] 0x00000f200000-0x00000f3fffff, RW_Data, RAM
 *                 [# 122] 0x00000f400000-0x00000f5fffff, RW_Data, RAM
 *                 [# 123] 0x00000f600000-0x00000f7fffff, RW_Data, RAM
 *                 [# 124] 0x00000f800000-0x00000f9fffff, RW_Data, RAM
 *                 [# 125] 0x00000fa00000-0x00000fbfffff, RW_Data, RAM
 *                 [# 126] 0x00000fc00000-0x00000fdfffff, RW_Data, RAM
 *                 [# 127] 0x00000fe00000-0x00000fffffff, RW_Data, RAM
 *                 [# 128] 0x000010000000-0x0000101fffff, RW_Data, RAM
 *                 [# 129] 0x000010200000-0x0000103fffff, RW_Data, RAM
 *                 [# 130] 0x000010400000-0x0000105fffff, RW_Data, RAM
 *                 [# 131] 0x000010600000-0x0000107fffff, RW_Data, RAM
 *                 [# 132] 0x000010800000-0x0000109fffff, RW_Data, RAM
 *                 [# 133] 0x000010a00000-0x000010bfffff, RW_Data, RAM
 *                 [# 134] 0x000010c00000-0x000010dfffff, RW_Data, RAM
 *                 [# 135] 0x000010e00000-0x000010ffffff, RW_Data, RAM
 *                 [# 136] 0x000011000000-0x0000111fffff, RW_Data, RAM
 *                 [# 137] 0x000011200000-0x0000113fffff, RW_Data, RAM
 *                 [# 138] 0x000011400000-0x0000115fffff, RW_Data, RAM
 *                 [# 139] 0x000011600000-0x0000117fffff, RW_Data, RAM
 *                 [# 140] 0x000011800000-0x0000119fffff, RW_Data, RAM
 *                 [# 141] 0x000011a00000-0x000011bfffff, RW_Data, RAM
 *                 [# 142] 0x000011c00000-0x000011dfffff, RW_Data, RAM
 *                 [# 143] 0x000011e00000-0x000011ffffff, RW_Data, RAM
 *                 [# 144] 0x000012000000-0x0000121fffff, RW_Data, RAM
 *                 [# 145] 0x000012200000-0x0000123fffff, RW_Data, RAM
 *                 [# 146] 0x000012400000-0x0000125fffff, RW_Data, RAM
 *                 [# 147] 0x000012600000-0x0000127fffff, RW_Data, RAM
 *                 [# 148] 0x000012800000-0x0000129fffff, RW_Data, RAM
 *                 [# 149] 0x000012a00000-0x000012bfffff, RW_Data, RAM
 *                 [# 150] 0x000012c00000-0x000012dfffff, RW_Data, RAM
 *                 [# 151] 0x000012e00000-0x000012ffffff, RW_Data, RAM
 *                 [# 152] 0x000013000000-0x0000131fffff, RW_Data, RAM
 *                 [# 153] 0x000013200000-0x0000133fffff, RW_Data, RAM
 *                 [# 154] 0x000013400000-0x0000135fffff, RW_Data, RAM
 *                 [# 155] 0x000013600000-0x0000137fffff, RW_Data, RAM
 *                 [# 156] 0x000013800000-0x0000139fffff, RW_Data, RAM
 *                 [# 157] 0x000013a00000-0x000013bfffff, RW_Data, RAM
 *                 [# 158] 0x000013c00000-0x000013dfffff, RW_Data, RAM
 *                 [# 159] 0x000013e00000-0x000013ffffff, RW_Data, RAM
 *                 [# 160] 0x000014000000-0x0000141fffff, RW_Data, RAM
 *                 [# 161] 0x000014200000-0x0000143fffff, RW_Data, RAM
 *                 [# 162] 0x000014400000-0x0000145fffff, RW_Data, RAM
 *                 [# 163] 0x000014600000-0x0000147fffff, RW_Data, RAM
 *                 [# 164] 0x000014800000-0x0000149fffff, RW_Data, RAM
 *                 [# 165] 0x000014a00000-0x000014bfffff, RW_Data, RAM
 *                 [# 166] 0x000014c00000-0x000014dfffff, RW_Data, RAM
 *                 [# 167] 0x000014e00000-0x000014ffffff, RW_Data, RAM
 *                 [# 168] 0x000015000000-0x0000151fffff, RW_Data, RAM
 *                 [# 169] 0x000015200000-0x0000153fffff, RW_Data, RAM
 *                 [# 170] 0x000015400000-0x0000155fffff, RW_Data, RAM
 *                 [# 171] 0x000015600000-0x0000157fffff, RW_Data, RAM
 *                 [# 172] 0x000015800000-0x0000159fffff, RW_Data, RAM
 *                 [# 173] 0x000015a00000-0x000015bfffff, RW_Data, RAM
 *                 [# 174] 0x000015c00000-0x000015dfffff, RW_Data, RAM
 *                 [# 175] 0x000015e00000-0x000015ffffff, RW_Data, RAM
 *                 [# 176] 0x000016000000-0x0000161fffff, RW_Data, RAM
 *                 [# 177] 0x000016200000-0x0000163fffff, RW_Data, RAM
 *                 [# 178] 0x000016400000-0x0000165fffff, RW_Data, RAM
 *                 [# 179] 0x000016600000-0x0000167fffff, RW_Data, RAM
 *                 [# 180] 0x000016800000-0x0000169fffff, RW_Data, RAM
 *                 [# 181] 0x000016a00000-0x000016bfffff, RW_Data, RAM
 *                 [# 182] 0x000016c00000-0x000016dfffff, RW_Data, RAM
 *                 [# 183] 0x000016e00000-0x000016ffffff, RW_Data, RAM
 *                 [# 184] 0x000017000000-0x0000171fffff, RW_Data, RAM
 *                 [# 185] 0x000017200000-0x0000173fffff, RW_Data, RAM
 *                 [# 186] 0x000017400000-0x0000175fffff, RW_Data, RAM
 *                 [# 187] 0x000017600000-0x0000177fffff, RW_Data, RAM
 *                 [# 188] 0x000017800000-0x0000179fffff, RW_Data, RAM
 *                 [# 189] 0x000017a00000-0x000017bfffff, RW_Data, RAM
 *                 [# 190] 0x000017c00000-0x000017dfffff, RW_Data, RAM
 *                 [# 191] 0x000017e00000-0x000017ffffff, RW_Data, RAM
 *                 [# 192] 0x000018000000-0x0000181fffff, RW_Data, RAM
 *                 [# 193] 0x000018200000-0x0000183fffff, RW_Data, RAM
 *                 [# 194] 0x000018400000-0x0000185fffff, RW_Data, RAM
 *                 [# 195] 0x000018600000-0x0000187fffff, RW_Data, RAM
 *                 [# 196] 0x000018800000-0x0000189fffff, RW_Data, RAM
 *                 [# 197] 0x000018a00000-0x000018bfffff, RW_Data, RAM
 *                 [# 198] 0x000018c00000-0x000018dfffff, RW_Data, RAM
 *                 [# 199] 0x000018e00000-0x000018ffffff, RW_Data, RAM
 *                 [# 200] 0x000019000000-0x0000191fffff, RW_Data, RAM
 *                 [# 201] 0x000019200000-0x0000193fffff, RW_Data, RAM
 *                 [# 202] 0x000019400000-0x0000195fffff, RW_Data, RAM
 *                 [# 203] 0x000019600000-0x0000197fffff, RW_Data, RAM
 *                 [# 204] 0x000019800000-0x0000199fffff, RW_Data, RAM
 *                 [# 205] 0x000019a00000-0x000019bfffff, RW_Data, RAM
 *                 [# 206] 0x000019c00000-0x000019dfffff, RW_Data, RAM
 *                 [# 207] 0x000019e00000-0x000019ffffff, RW_Data, RAM
 *                 [# 208] 0x00001a000000-0x00001a1fffff, RW_Data, RAM
 *                 [# 209] 0x00001a200000-0x00001a3fffff, RW_Data, RAM
 *                 [# 210] 0x00001a400000-0x00001a5fffff, RW_Data, RAM
 *                 [# 211] 0x00001a600000-0x00001a7fffff, RW_Data, RAM
 *                 [# 212] 0x00001a800000-0x00001a9fffff, RW_Data, RAM
 *                 [# 213] 0x00001aa00000-0x00001abfffff, RW_Data, RAM
 *                 [# 214] 0x00001ac00000-0x00001adfffff, RW_Data, RAM
 *                 [# 215] 0x00001ae00000-0x00001affffff, RW_Data, RAM
 *                 [# 216] 0x00001b000000-0x00001b1fffff, RW_Data, RAM
 *                 [# 217] 0x00001b200000-0x00001b3fffff, RW_Data, RAM
 *                 [# 218] 0x00001b400000-0x00001b5fffff, RW_Data, RAM
 *                 [# 219] 0x00001b600000-0x00001b7fffff, RW_Data, RAM
 *                 [# 220] 0x00001b800000-0x00001b9fffff, RW_Data, RAM
 *                 [# 221] 0x00001ba00000-0x00001bbfffff, RW_Data, RAM
 *                 [# 222] 0x00001bc00000-0x00001bdfffff, RW_Data, RAM
 *                 [# 223] 0x00001be00000-0x00001bffffff, RW_Data, RAM
 *                 [# 224] 0x00001c000000-0x00001c1fffff, RW_Data, RAM
 *                 [# 225] 0x00001c200000-0x00001c3fffff, RW_Data, RAM
 *                 [# 226] 0x00001c400000-0x00001c5fffff, RW_Data, RAM
 *                 [# 227] 0x00001c600000-0x00001c7fffff, RW_Data, RAM
 *                 [# 228] 0x00001c800000-0x00001c9fffff, RW_Data, RAM
 *                 [# 229] 0x00001ca00000-0x00001cbfffff, RW_Data, RAM
 *                 [# 230] 0x00001cc00000-0x00001cdfffff, RW_Data, RAM
 *                 [# 231] 0x00001ce00000-0x00001cffffff, RW_Data, RAM
 *                 [# 232] 0x00001d000000-0x00001d1fffff, RW_Data, RAM
 *                 [# 233] 0x00001d200000-0x00001d3fffff, RW_Data, RAM
 *                 [# 234] 0x00001d400000-0x00001d5fffff, RW_Data, RAM
 *                 [# 235] 0x00001d600000-0x00001d7fffff, RW_Data, RAM
 *                 [# 236] 0x00001d800000-0x00001d9fffff, RW_Data, RAM
 *                 [# 237] 0x00001da00000-0x00001dbfffff, RW_Data, RAM
 *                 [# 238] 0x00001dc00000-0x00001ddfffff, RW_Data, RAM
 *                 [# 239] 0x00001de00000-0x00001dffffff, RW_Data, RAM
 *                 [# 240] 0x00001e000000-0x00001e1fffff, RW_Data, RAM
 *                 [# 241] 0x00001e200000-0x00001e3fffff, RW_Data, RAM
 *                 [# 242] 0x00001e400000-0x00001e5fffff, RW_Data, RAM
 *                 [# 243] 0x00001e600000-0x00001e7fffff, RW_Data, RAM
 *                 [# 244] 0x00001e800000-0x00001e9fffff, RW_Data, RAM
 *                 [# 245] 0x00001ea00000-0x00001ebfffff, RW_Data, RAM
 *                 [# 246] 0x00001ec00000-0x00001edfffff, RW_Data, RAM
 *                 [# 247] 0x00001ee00000-0x00001effffff, RW_Data, RAM
 *                 [# 248] 0x00001f000000-0x00001f1fffff, RW_Data, RAM
 *                 [# 249] 0x00001f200000-0x00001f3fffff, RW_Data, RAM
 *                 [# 250] 0x00001f400000-0x00001f5fffff, RW_Data, RAM
 *                 [# 251] 0x00001f600000-0x00001f7fffff, RW_Data, RAM
 *                 [# 252] 0x00001f800000-0x00001f9fffff, RW_Data, RAM
 *                 [# 253] 0x00001fa00000-0x00001fbfffff, RW_Data, RAM
 *                 [# 254] 0x00001fc00000-0x00001fdfffff, RW_Data, RAM
 *                 [# 255] 0x00001fe00000-0x00001fffffff, RW_Data, RAM
 *                 [# 256] 0x000020000000-0x0000201fffff, RW_Data, RAM
 *                 [# 257] 0x000020200000-0x0000203fffff, RW_Data, RAM
 *                 [# 258] 0x000020400000-0x0000205fffff, RW_Data, RAM
 *                 [# 259] 0x000020600000-0x0000207fffff, RW_Data, RAM
 *                 [# 260] 0x000020800000-0x0000209fffff, RW_Data, RAM
 *                 [# 261] 0x000020a00000-0x000020bfffff, RW_Data, RAM
 *                 [# 262] 0x000020c00000-0x000020dfffff, RW_Data, RAM
 *                 [# 263] 0x000020e00000-0x000020ffffff, RW_Data, RAM
 *                 [# 264] 0x000021000000-0x0000211fffff, RW_Data, RAM
 *                 [# 265] 0x000021200000-0x0000213fffff, RW_Data, RAM
 *                 [# 266] 0x000021400000-0x0000215fffff, RW_Data, RAM
 *                 [# 267] 0x000021600000-0x0000217fffff, RW_Data, RAM
 *                 [# 268] 0x000021800000-0x0000219fffff, RW_Data, RAM
 *                 [# 269] 0x000021a00000-0x000021bfffff, RW_Data, RAM
 *                 [# 270] 0x000021c00000-0x000021dfffff, RW_Data, RAM
 *                 [# 271] 0x000021e00000-0x000021ffffff, RW_Data, RAM
 *                 [# 272] 0x000022000000-0x0000221fffff, RW_Data, RAM
 *                 [# 273] 0x000022200000-0x0000223fffff, RW_Data, RAM
 *                 [# 274] 0x000022400000-0x0000225fffff, RW_Data, RAM
 *                 [# 275] 0x000022600000-0x0000227fffff, RW_Data, RAM
 *                 [# 276] 0x000022800000-0x0000229fffff, RW_Data, RAM
 *                 [# 277] 0x000022a00000-0x000022bfffff, RW_Data, RAM
 *                 [# 278] 0x000022c00000-0x000022dfffff, RW_Data, RAM
 *                 [# 279] 0x000022e00000-0x000022ffffff, RW_Data, RAM
 *                 [# 280] 0x000023000000-0x0000231fffff, RW_Data, RAM
 *                 [# 281] 0x000023200000-0x0000233fffff, RW_Data, RAM
 *                 [# 282] 0x000023400000-0x0000235fffff, RW_Data, RAM
 *                 [# 283] 0x000023600000-0x0000237fffff, RW_Data, RAM
 *                 [# 284] 0x000023800000-0x0000239fffff, RW_Data, RAM
 *                 [# 285] 0x000023a00000-0x000023bfffff, RW_Data, RAM
 *                 [# 286] 0x000023c00000-0x000023dfffff, RW_Data, RAM
 *                 [# 287] 0x000023e00000-0x000023ffffff, RW_Data, RAM
 *                 [# 288] 0x000024000000-0x0000241fffff, RW_Data, RAM
 *                 [# 289] 0x000024200000-0x0000243fffff, RW_Data, RAM
 *                 [# 290] 0x000024400000-0x0000245fffff, RW_Data, RAM
 *                 [# 291] 0x000024600000-0x0000247fffff, RW_Data, RAM
 *                 [# 292] 0x000024800000-0x0000249fffff, RW_Data, RAM
 *                 [# 293] 0x000024a00000-0x000024bfffff, RW_Data, RAM
 *                 [# 294] 0x000024c00000-0x000024dfffff, RW_Data, RAM
 *                 [# 295] 0x000024e00000-0x000024ffffff, RW_Data, RAM
 *                 [# 296] 0x000025000000-0x0000251fffff, RW_Data, RAM
 *                 [# 297] 0x000025200000-0x0000253fffff, RW_Data, RAM
 *                 [# 298] 0x000025400000-0x0000255fffff, RW_Data, RAM
 *                 [# 299] 0x000025600000-0x0000257fffff, RW_Data, RAM
 *                 [# 300] 0x000025800000-0x0000259fffff, RW_Data, RAM
 *                 [# 301] 0x000025a00000-0x000025bfffff, RW_Data, RAM
 *                 [# 302] 0x000025c00000-0x000025dfffff, RW_Data, RAM
 *                 [# 303] 0x000025e00000-0x000025ffffff, RW_Data, RAM
 *                 [# 304] 0x000026000000-0x0000261fffff, RW_Data, RAM
 *                 [# 305] 0x000026200000-0x0000263fffff, RW_Data, RAM
 *                 [# 306] 0x000026400000-0x0000265fffff, RW_Data, RAM
 *                 [# 307] 0x000026600000-0x0000267fffff, RW_Data, RAM
 *                 [# 308] 0x000026800000-0x0000269fffff, RW_Data, RAM
 *                 [# 309] 0x000026a00000-0x000026bfffff, RW_Data, RAM
 *                 [# 310] 0x000026c00000-0x000026dfffff, RW_Data, RAM
 *                 [# 311] 0x000026e00000-0x000026ffffff, RW_Data, RAM
 *                 [# 312] 0x000027000000-0x0000271fffff, RW_Data, RAM
 *                 [# 313] 0x000027200000-0x0000273fffff, RW_Data, RAM
 *                 [# 314] 0x000027400000-0x0000275fffff, RW_Data, RAM
 *                 [# 315] 0x000027600000-0x0000277fffff, RW_Data, RAM
 *                 [# 316] 0x000027800000-0x0000279fffff, RW_Data, RAM
 *                 [# 317] 0x000027a00000-0x000027bfffff, RW_Data, RAM
 *                 [# 318] 0x000027c00000-0x000027dfffff, RW_Data, RAM
 *                 [# 319] 0x000027e00000-0x000027ffffff, RW_Data, RAM
 *                 [# 320] 0x000028000000-0x0000281fffff, RW_Data, RAM
 *                 [# 321] 0x000028200000-0x0000283fffff, RW_Data, RAM
 *                 [# 322] 0x000028400000-0x0000285fffff, RW_Data, RAM
 *                 [# 323] 0x000028600000-0x0000287fffff, RW_Data, RAM
 *                 [# 324] 0x000028800000-0x0000289fffff, RW_Data, RAM
 *                 [# 325] 0x000028a00000-0x000028bfffff, RW_Data, RAM
 *                 [# 326] 0x000028c00000-0x000028dfffff, RW_Data, RAM
 *                 [# 327] 0x000028e00000-0x000028ffffff, RW_Data, RAM
 *                 [# 328] 0x000029000000-0x0000291fffff, RW_Data, RAM
 *                 [# 329] 0x000029200000-0x0000293fffff, RW_Data, RAM
 *                 [# 330] 0x000029400000-0x0000295fffff, RW_Data, RAM
 *                 [# 331] 0x000029600000-0x0000297fffff, RW_Data, RAM
 *                 [# 332] 0x000029800000-0x0000299fffff, RW_Data, RAM
 *                 [# 333] 0x000029a00000-0x000029bfffff, RW_Data, RAM
 *                 [# 334] 0x000029c00000-0x000029dfffff, RW_Data, RAM
 *                 [# 335] 0x000029e00000-0x000029ffffff, RW_Data, RAM
 *                 [# 336] 0x00002a000000-0x00002a1fffff, RW_Data, RAM
 *                 [# 337] 0x00002a200000-0x00002a3fffff, RW_Data, RAM
 *                 [# 338] 0x00002a400000-0x00002a5fffff, RW_Data, RAM
 *                 [# 339] 0x00002a600000-0x00002a7fffff, RW_Data, RAM
 *                 [# 340] 0x00002a800000-0x00002a9fffff, RW_Data, RAM
 *                 [# 341] 0x00002aa00000-0x00002abfffff, RW_Data, RAM
 *                 [# 342] 0x00002ac00000-0x00002adfffff, RW_Data, RAM
 *                 [# 343] 0x00002ae00000-0x00002affffff, RW_Data, RAM
 *                 [# 344] 0x00002b000000-0x00002b1fffff, RW_Data, RAM
 *                 [# 345] 0x00002b200000-0x00002b3fffff, RW_Data, RAM
 *                 [# 346] 0x00002b400000-0x00002b5fffff, RW_Data, RAM
 *                 [# 347] 0x00002b600000-0x00002b7fffff, RW_Data, RAM
 *                 [# 348] 0x00002b800000-0x00002b9fffff, RW_Data, RAM
 *                 [# 349] 0x00002ba00000-0x00002bbfffff, RW_Data, RAM
 *                 [# 350] 0x00002bc00000-0x00002bdfffff, RW_Data, RAM
 *                 [# 351] 0x00002be00000-0x00002bffffff, RW_Data, RAM
 *                 [# 352] 0x00002c000000-0x00002c1fffff, RW_Data, RAM
 *                 [# 353] 0x00002c200000-0x00002c3fffff, RW_Data, RAM
 *                 [# 354] 0x00002c400000-0x00002c5fffff, RW_Data, RAM
 *                 [# 355] 0x00002c600000-0x00002c7fffff, RW_Data, RAM
 *                 [# 356] 0x00002c800000-0x00002c9fffff, RW_Data, RAM
 *                 [# 357] 0x00002ca00000-0x00002cbfffff, RW_Data, RAM
 *                 [# 358] 0x00002cc00000-0x00002cdfffff, RW_Data, RAM
 *                 [# 359] 0x00002ce00000-0x00002cffffff, RW_Data, RAM
 *                 [# 360] 0x00002d000000-0x00002d1fffff, RW_Data, RAM
 *                 [# 361] 0x00002d200000-0x00002d3fffff, RW_Data, RAM
 *                 [# 362] 0x00002d400000-0x00002d5fffff, RW_Data, RAM
 *                 [# 363] 0x00002d600000-0x00002d7fffff, RW_Data, RAM
 *                 [# 364] 0x00002d800000-0x00002d9fffff, RW_Data, RAM
 *                 [# 365] 0x00002da00000-0x00002dbfffff, RW_Data, RAM
 *                 [# 366] 0x00002dc00000-0x00002ddfffff, RW_Data, RAM
 *                 [# 367] 0x00002de00000-0x00002dffffff, RW_Data, RAM
 *                 [# 368] 0x00002e000000-0x00002e1fffff, RW_Data, RAM
 *                 [# 369] 0x00002e200000-0x00002e3fffff, RW_Data, RAM
 *                 [# 370] 0x00002e400000-0x00002e5fffff, RW_Data, RAM
 *                 [# 371] 0x00002e600000-0x00002e7fffff, RW_Data, RAM
 *                 [# 372] 0x00002e800000-0x00002e9fffff, RW_Data, RAM
 *                 [# 373] 0x00002ea00000-0x00002ebfffff, RW_Data, RAM
 *                 [# 374] 0x00002ec00000-0x00002edfffff, RW_Data, RAM
 *                 [# 375] 0x00002ee00000-0x00002effffff, RW_Data, RAM
 *                 [# 376] 0x00002f000000-0x00002f1fffff, RW_Data, RAM
 *                 [# 377] 0x00002f200000-0x00002f3fffff, RW_Data, RAM
 *                 [# 378] 0x00002f400000-0x00002f5fffff, RW_Data, RAM
 *                 [# 379] 0x00002f600000-0x00002f7fffff, RW_Data, RAM
 *                 [# 380] 0x00002f800000-0x00002f9fffff, RW_Data, RAM
 *                 [# 381] 0x00002fa00000-0x00002fbfffff, RW_Data, RAM
 *                 [# 382] 0x00002fc00000-0x00002fdfffff, RW_Data, RAM
 *                 [# 383] 0x00002fe00000-0x00002fffffff, RW_Data, RAM
 *                 [# 384] 0x000030000000-0x0000301fffff, RW_Data, RAM
 *                 [# 385] 0x000030200000-0x0000303fffff, RW_Data, RAM
 *                 [# 386] 0x000030400000-0x0000305fffff, RW_Data, RAM
 *                 [# 387] 0x000030600000-0x0000307fffff, RW_Data, RAM
 *                 [# 388] 0x000030800000-0x0000309fffff, RW_Data, RAM
 *                 [# 389] 0x000030a00000-0x000030bfffff, RW_Data, RAM
 *                 [# 390] 0x000030c00000-0x000030dfffff, RW_Data, RAM
 *                 [# 391] 0x000030e00000-0x000030ffffff, RW_Data, RAM
 *         [#   1]---------------------------\
 *                 level 2 table @ 0x2f002000
 *                 [#   0] 0x000040000000-0x0000401fffff, RW_Data, TTB
 *                 [#   1] 0x000040200000-0x0000403fffff, RW_Data, TTB
 *                 [#   2] 0x000040400000-0x0000405fffff, RW_Data, TTB
 *                 [#   3] 0x000040600000-0x0000407fffff, RW_Data, TTB
 *                 [#   4] 0x000040800000-0x0000409fffff, RW_Data, TTB
 *                 [#   5] 0x000040a00000-0x000040bfffff, RW_Data, TTB
 *                 [#   6] 0x000040c00000-0x000040dfffff, RW_Data, TTB
 *                 [#   7] 0x000040e00000-0x000040ffffff, RW_Data, TTB
 *                 [#   8] 0x000041000000-0x0000411fffff, RW_Data, TTB
 *                 [#   9] 0x000041200000-0x0000413fffff, RW_Data, TTB
 *                 [#  10] 0x000041400000-0x0000415fffff, RW_Data, TTB
 *                 [#  11] 0x000041600000-0x0000417fffff, RW_Data, TTB
 *                 [#  12] 0x000041800000-0x0000419fffff, RW_Data, TTB
 *                 [#  13] 0x000041a00000-0x000041bfffff, RW_Data, TTB
 *                 [#  14] 0x000041c00000-0x000041dfffff, RW_Data, TTB
 *                 [#  15] 0x000041e00000-0x000041ffffff, RW_Data, TTB
 *                 [#  16] 0x000042000000-0x0000421fffff, RW_Data, TTB
 *                 [#  17] 0x000042200000-0x0000423fffff, RW_Data, TTB
 *                 [#  18] 0x000042400000-0x0000425fffff, RW_Data, TTB
 *                 [#  19] 0x000042600000-0x0000427fffff, RW_Data, TTB
 *                 [#  20] 0x000042800000-0x0000429fffff, RW_Data, TTB
 *                 [#  21] 0x000042a00000-0x000042bfffff, RW_Data, TTB
 *                 [#  22] 0x000042c00000-0x000042dfffff, RW_Data, TTB
 *                 [#  23] 0x000042e00000-0x000042ffffff, RW_Data, TTB
 *                 [#  24] 0x000043000000-0x0000431fffff, RW_Data, TTB
 *                 [#  25] 0x000043200000-0x0000433fffff, RW_Data, TTB
 *                 [#  26] 0x000043400000-0x0000435fffff, RW_Data, TTB
 *                 [#  27] 0x000043600000-0x0000437fffff, RW_Data, TTB
 *                 [#  28] 0x000043800000-0x0000439fffff, RW_Data, TTB
 *                 [#  29] 0x000043a00000-0x000043bfffff, RW_Data, TTB
 *                 [#  30] 0x000043c00000-0x000043dfffff, RW_Data, TTB
 *                 [#  31] 0x000043e00000-0x000043ffffff, RW_Data, TTB
 *         [#   3]---------------------------\
 *                 level 2 table @ 0x2f003000
 *                 [# 480] 0x0000fc000000-0x0000fc1fffff, Device, ARM_PERI
 *                 [# 481] 0x0000fc200000-0x0000fc3fffff, Device, ARM_PERI
 *                 [# 482] 0x0000fc400000-0x0000fc5fffff, Device, ARM_PERI
 *                 [# 483] 0x0000fc600000-0x0000fc7fffff, Device, ARM_PERI
 *                 [# 484] 0x0000fc800000-0x0000fc9fffff, Device, ARM_PERI
 *                 [# 485] 0x0000fca00000-0x0000fcbfffff, Device, ARM_PERI
 *                 [# 486] 0x0000fcc00000-0x0000fcdfffff, Device, ARM_PERI
 *                 [# 487] 0x0000fce00000-0x0000fcffffff, Device, ARM_PERI
 *                 [# 488] 0x0000fd000000-0x0000fd1fffff, Device, ARM_PERI
 *                 [# 489] 0x0000fd200000-0x0000fd3fffff, Device, ARM_PERI
 *                 [# 490] 0x0000fd400000-0x0000fd5fffff, Device, ARM_PERI
 *                 [# 491] 0x0000fd600000-0x0000fd7fffff, Device, ARM_PERI
 *                 [# 492] 0x0000fd800000-0x0000fd9fffff, Device, ARM_PERI
 *                 [# 493] 0x0000fda00000-0x0000fdbfffff, Device, ARM_PERI
 *                 [# 494] 0x0000fdc00000-0x0000fddfffff, Device, ARM_PERI
 *                 [# 495] 0x0000fde00000-0x0000fdffffff, Device, ARM_PERI
 *                 [# 496] 0x0000fe000000-0x0000fe1fffff, Device, ARM_PERI
 *                 [# 497] 0x0000fe200000-0x0000fe3fffff, Device, ARM_PERI
 *                 [# 498] 0x0000fe400000-0x0000fe5fffff, Device, ARM_PERI
 *                 [# 499] 0x0000fe600000-0x0000fe7fffff, Device, ARM_PERI
 *                 [# 500] 0x0000fe800000-0x0000fe9fffff, Device, ARM_PERI
 *                 [# 501] 0x0000fea00000-0x0000febfffff, Device, ARM_PERI
 *                 [# 502] 0x0000fec00000-0x0000fedfffff, Device, ARM_PERI
 *                 [# 503] 0x0000fee00000-0x0000feffffff, Device, ARM_PERI
 *                 [# 504] 0x0000ff000000-0x0000ff1fffff, Device, ARM_PERI
 *                 [# 505] 0x0000ff200000-0x0000ff3fffff, Device, ARM_PERI
 *                 [# 506] 0x0000ff400000-0x0000ff5fffff, Device, ARM_PERI
 *                 [# 507] 0x0000ff600000-0x0000ff7fffff, Device, ARM_PERI
 *                 [# 508] 0x0000ff800000-0x0000ff9fffff, Device, ARM_PERI
 *                 [# 509] 0x0000ffa00000-0x0000ffbfffff, Device, ARM_PERI
 *                 [# 510] 0x0000ffc00000-0x0000ffdfffff, Device, ARM_PERI
 *                 [# 511] 0x0000ffe00000-0x0000ffffffff, Device, ARM_PERI
 *
 * The following command line arguments were passed to arm64-pgtable-tool:
 *
 *      -i mmu_map.txt
 *      -ttb 0x2f000000
 *      -el 1
 *      -tg 4K
 *      -tsz 32
 *
 * This memory map requires a total of 4 translation tables.
 * Each table occupies 4K of memory (0x1000 bytes).
 * The buffer pointed to by 0x2f000000 must therefore be 4x 4K = 0x4000 bytes long.
 * It is the programmer's responsibility to guarantee this.
 *
 * The programmer must also ensure that the virtual memory region containing the
 * translation tables is itself marked as NORMAL in the memory map file.
 */

    .section .data.mmu
    .balign 2

    mmu_lock: .4byte 0                   // lock to ensure only 1 CPU runs init
    #define LOCKED 1

    mmu_init: .4byte 0                   // whether init has been run
    #define INITIALISED 1

    .section .text.mmu_on
    .balign 2
    .global mmu_on
    .type mmu_on, @function

mmu_on:

check_already_initialised:

    ADRP    x1, mmu_init                 // get 4KB page containing mmu_init
    ADD     x1, x1, :lo12:mmu_init       // restore low 12 bits lost by ADRP
    LDR     w2, [x1]                     // read mmu_init
    CBNZ    w2, end                      // init already done, skip to the end

zero_out_tables:

    LDR     x2, =0x2f000000              // address of first table
    LDR     x3, =0x4000                  // combined length of all tables
    LSR     x3, x3, #5                   // number of required STP instructions
    FMOV    d0, xzr                      // clear q0
1:
    STP     q0, q0, [x2], #32            // zero out 4 table entries at a time
    SUBS    x3, x3, #1
    B.NE    1b

load_descriptor_templates:

    LDR     x2, =0x20000000000705        // Device block
    LDR     x3, =0x20000000000707        // Device page
    LDR     x4, =0x20000000000701        // RW data block
    LDR     x5, =0x20000000000703        // RW data page
    LDR     x20, =0x781                  // code block
    LDR     x21, =0x783                  // code page
    

program_table_0:

    LDR     x8, =0x2f000000              // base address of this table
    LDR     x9, =0x40000000              // chunk size

program_table_0_entry_0:

    LDR     x10, =0                      // idx
    LDR     x11, =0x2f001000             // next-level table address
    ORR     x11, x11, #0x3               // next-level table descriptor
    STR     x11, [x8, x10, lsl #3]       // write entry into table

program_table_0_entry_1:

    LDR     x10, =1                      // idx
    LDR     x11, =0x2f002000             // next-level table address
    ORR     x11, x11, #0x3               // next-level table descriptor
    STR     x11, [x8, x10, lsl #3]       // write entry into table

program_table_0_entry_3:

    LDR     x10, =3                      // idx
    LDR     x11, =0x2f003000             // next-level table address
    ORR     x11, x11, #0x3               // next-level table descriptor
    STR     x11, [x8, x10, lsl #3]       // write entry into table
program_table_1:

    LDR     x8, =0x2f001000              // base address of this table
    LDR     x9, =0x200000                // chunk size

program_table_1_entry_0_to_7:

    LDR     x10, =0                      // idx
    LDR     x11, =8                      // number of contiguous entries
    LDR     x12, =0x0                    // output address of entry[idx]
1:
    ORR     x12, x12, x20                // merge output address with template
    STR     X12, [x8, x10, lsl #3]       // write entry into table
    ADD     x10, x10, #1                 // prepare for next entry idx+1
    ADD     x12, x12, x9                 // add chunk to address
    SUBS    x11, x11, #1                 // loop as required
    B.NE    1b

program_table_1_entry_8_to_391:

    LDR     x10, =8                      // idx
    LDR     x11, =384                    // number of contiguous entries
    LDR     x12, =0x1000000              // output address of entry[idx]
1:
    ORR     x12, x12, x4                 // merge output address with template
    STR     X12, [x8, x10, lsl #3]       // write entry into table
    ADD     x10, x10, #1                 // prepare for next entry idx+1
    ADD     x12, x12, x9                 // add chunk to address
    SUBS    x11, x11, #1                 // loop as required
    B.NE    1b
program_table_2:

    LDR     x8, =0x2f002000              // base address of this table
    LDR     x9, =0x200000                // chunk size

program_table_2_entry_0_to_31:

    LDR     x10, =0                      // idx
    LDR     x11, =32                     // number of contiguous entries
    LDR     x12, =0x40000000             // output address of entry[idx]
1:
    ORR     x12, x12, x4                 // merge output address with template
    STR     X12, [x8, x10, lsl #3]       // write entry into table
    ADD     x10, x10, #1                 // prepare for next entry idx+1
    ADD     x12, x12, x9                 // add chunk to address
    SUBS    x11, x11, #1                 // loop as required
    B.NE    1b
program_table_3:

    LDR     x8, =0x2f003000              // base address of this table
    LDR     x9, =0x200000                // chunk size

program_table_3_entry_480_to_511:

    LDR     x10, =480                    // idx
    LDR     x11, =32                     // number of contiguous entries
    LDR     x12, =0xfc000000             // output address of entry[idx]
1:
    ORR     x12, x12, x2                 // merge output address with template
    STR     X12, [x8, x10, lsl #3]       // write entry into table
    ADD     x10, x10, #1                 // prepare for next entry idx+1
    ADD     x12, x12, x9                 // add chunk to address
    SUBS    x11, x11, #1                 // loop as required
    B.NE    1b

init_done:

    MOV     w2, #INITIALISED
    STR     w2, [x1]

end:

    LDR     x1, =0x2f000000              // program ttbr0 on this CPU
    MSR     ttbr0_el1, x1
    LDR     x1, =0xff                    // program mair on this CPU
    MSR     mair_el1, x1
    LDR     x1, =0x803520                // program tcr on this CPU
    MSR     tcr_el1, x1
    ISB
    MRS     x2, tcr_el1                  // verify CPU supports desired config
    CMP     x2, x1
    B.NE    .
    LDR     x1, =0x1005                  // program sctlr on this CPU
    MSR     sctlr_el1, x1
    ISB                                  // synchronize context on this CPU
    RET                                  // done!
