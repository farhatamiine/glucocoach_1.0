import {useMutation} from "@tanstack/react-query";
import {loginWithPasswordFetcher} from "@/features/auth/services/loginWithPasswordFetcher";
import {LoginFormValues} from "@/features/auth/schemas/login.schema";
import {useRouter} from "next/navigation";
import {DASHBOARD_PATH} from "@/const/pathNames";


const useLoginForm = () => {
    const router = useRouter();
    const {isSuccess, isPending, isError, mutate} = useMutation({
        mutationFn: async ({email, password}: LoginFormValues) => {
            console.log('login mutation called');
            return await loginWithPasswordFetcher(email, password);
        },
        onError: (error) => {
            console.log(error);
        },
        onSuccess: () => {
            router.push(DASHBOARD_PATH);
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