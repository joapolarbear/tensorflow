#include <string>
#include <iostream>
#include "tensorflow/compiler/byteprofile_xlatools/compile_to_hlo.h"
#include "tensorflow/compiler/byteprofile_xlatools/gen_feature_vector.h"
#include "tensorflow/compiler/byteprofile_xlatools/c_api.h"

extern "C" {
    int C_API_CompileToHlo(const char* graph_path, const char* config_path, 
                            const char* dump_path_unopt, const char* dump_path_opt) {
        std::string graph_path_str(graph_path);
        std::string config_path_str(config_path);
        std::string dump_path_unopt_str(dump_path_unopt);
        std::string dump_path_opt_str(dump_path_opt);
        // std::cout << "In C_API.cc: " << config_path << std::endl;
        tensorflow::Status status = byteprofile::xlatools::CompileToHlo(graph_path_str, config_path_str, dump_path_unopt_str, dump_path_opt_str);
        if (status != tensorflow::Status::OK()) {
            std::cout << "Failed to compile HLO." << std::endl;
            return -1;
        }
        return 0;
    }

} // extern "C"
