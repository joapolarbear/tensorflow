#ifndef BYTEPROFILE_COST_MODEL_C_API_H
#define BYTEPROFILE_COST_MODEL_C_API_H

extern "C" {
    int C_API_CompileToHlo(const char* graph_path, const char* config_path, 
                            const char* dump_path_unopt, const char* dump_path_opt);
    
} // extern "C"

#endif //BYTEPROFILE_COST_MODEL_C_API_H
