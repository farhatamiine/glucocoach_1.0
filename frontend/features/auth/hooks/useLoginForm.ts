import {useMutation} from "@tanstack/react-query";
import {loginWithPasswordFetcher} from "@/features/auth/services/loginWithPasswordFetcher";
import {LoginFormValues} from "@/features/auth/schemas/login.schema";

const useLoginForm = () => {

    const {isSuccess, isPending, isError, mutate} = useMutation({
        mutationFn: async ({email, password}: LoginFormValues) => {
            console.log('login mutation called');
            return await loginWithPasswordFetcher(email, password);
        },
        onError: (error) => {
            console.log(error);
        },
        onSuccess: (data) => {
            console.log(data);
        },

    })


    return {
        loginMutation: mutate,
        isLoggingIn: isPending,
        isSuccess: isSuccess,
        isError: isError,
    }
};


export default useLoginForm;