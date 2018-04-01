# Polar Bytecode Instructions
## Introducing
Polar Bytecode Instructions is a designed instruction set of the Polar Virtual Runtime (PVR).
With this manual, you may understand the PBI roughly, more details please step forward to the WIKI (if there is).
The PBI uses 2 bytes to indicate the instruction which you may find them in the instructions table below.

## Something must known
* The PBI is not only designed for `PolarBasic`, I am very greatful that someone wanted to participate compilers of other languages.
* The PBI is under developing so far, so everything could be changed.
* Due to my limited knowledges, I am very sure that I am making some awful mistakes, so please fix me up if you'd happy to do that.
* Very appreciated!

## INSTRUCTIONS

### Category summaries

|Cateogry|Name|
| ------------ | ------------ |
|0x01 - 0x0f|Declares|
|0x20 - 0x2F|Loads & Saves|
|0x30 - 0x3F|Calculations|

### Category 0x01 - 0x0F: Declares

|Category (High)|Opercode (Low)|Bytecode|Instruction|
| ------------ | ------------ | ------------ | ------------ |
|0x01|0x1|0x0101|PBI_FUNC|
|0x02|0x1|0x0201|PBI_TYPE|

### Category 0x10 - 0x1F: Loads & Saves

|Category (High)|Opercode (Low)|Bytecode|Instruction|
| ------------ | ------------ | ------------ | ------------ |
|0x10|None|None|PBI_CONST|
|0x10|0x01|0x1001|PBI_CONST_S|
|0x10|0x02|0x1002|PBI_CONST_I|
|0x10|0x03|0x1003|PBI_CONST_L|
|0x10|0x04|0x1004|PBI_CONST_F|
|0x10|0x05|0x1005|PBI_CONST_D|
|0x10|0x06|0x1006|PBI_CONST_T|
|0x10|0x07|0x1007|PBI_CONST_B|
|0x11|None|None|PBI_LOAD|
|0x11|0x01|0x1101|PBI_LOAD_S|
|0x11|0x02|0x1102|PBI_LOAD_I|
|0x11|0x03|0x1103|PBI_LOAD_L|
|0x11|0x04|0x1104|PBI_LOAD_F|
|0x11|0x05|0x1105|PBI_LOAD_D|
|0x11|0x06|0x1106|PBI_LOAD_T|
|0x11|0x07|0x1107|PBI_LOAD_B|
|0x12|0x00|0x1200|PBI_SAVE|
|0x12|0x01|0x1201|PBI_SAVE_S|
|0x12|0x02|0x1202|PBI_SAVE_I|
|0x12|0x03|0x1203|PBI_SAVE_L|
|0x12|0x04|0x1204|PBI_SAVE_F|
|0x12|0x05|0x1205|PBI_SAVE_D|
|0x12|0x06|0x1206|PBI_SAVE_T|
|0x12|0x07|0x1207|PBI_SAVE_B|
|0x13|0x00|0x1300|PBI_RETURN|
|0x13|0x01|0x1301|PBI_RETURN_S|
|0x13|0x02|0x1302|PBI_RETURN_I|
|0x13|0x03|0x1303|PBI_RETURN_L|
|0x13|0x04|0x1304|PBI_RETURN_F|
|0x13|0x05|0x1305|PBI_RETURN_D|
|0x13|0x06|0x1306|PBI_RETURN_T|
|0x13|0x07|0x1307|PBI_RETURN_B|
