################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
Echo_Fading.obj: ../Echo_Fading.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv6/tools/compiler/c6000_7.4.18/bin/cl6x" -mv6713 --abi=coffabi -g --include_path="D:/Exp5/C6xCSL/include" --include_path="D:/Exp5/DSK6713/c6000/dsk6713/include" --include_path="C:/ti/ccsv6/tools/compiler/c6000_7.4.18/include" --diag_wrap=off --diag_warning=225 --display_error_number --mem_model:const=far --mem_model:data=far --preproc_with_compile --preproc_dependency="Echo_Fading.d" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

vectors.obj: ../vectors.asm $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv6/tools/compiler/c6000_7.4.18/bin/cl6x" -mv6713 --abi=coffabi -g --include_path="D:/Exp5/C6xCSL/include" --include_path="D:/Exp5/DSK6713/c6000/dsk6713/include" --include_path="C:/ti/ccsv6/tools/compiler/c6000_7.4.18/include" --diag_wrap=off --diag_warning=225 --display_error_number --mem_model:const=far --mem_model:data=far --preproc_with_compile --preproc_dependency="vectors.d" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


